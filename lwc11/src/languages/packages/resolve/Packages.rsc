module languages::packages::resolve::Packages

import languages::packages::ast::Packages;
import languages::entities::ast::Entities;
import languages::packages::check::Packages;
import languages::packages::utils::Load;

import IO;

public map[str, LoadResult] resolve(map[str, LoadResult] pkgs) {
	// replace all identifiers with long identifiers
	// assumptions: all imports  are in pkgs
	//   there may be cycles
	//   no nested packages
	//   imports are non transitive
	//	 entities are declared out of order and may have cyclic deps
	//   if a package imports 2 packages that export the same name it is an error
	//	  (here we assume this has already been checked for)
	
	for (k <- pkgs, success(l, pkg) := pkgs[k]) {
		imps = imports(pkg) + {pkg.name};
		pkg = visit (pkg) {
			case Name n:name(str x): {
				if (i <- imps, success(_, p2) := pkgs[i], x in exports(p2)) {
					insert qualified(p2.name, x)[@location=n@location];
				}
				throw "Undefined or unimported name <x>";
			}
		}
		pkgs[k] = success(l, pkg);
	}
	return pkgs;
}

