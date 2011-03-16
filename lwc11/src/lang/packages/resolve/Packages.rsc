module lang::packages::resolve::Packages

import lang::packages::ast::Packages;
import lang::entities::ast::Entities;
import lang::packages::check::Packages;
import lang::packages::utils::Load;

import IO;

public WorkingSet resolve(WorkingSet pkgs) {
	// replace all identifiers with long identifiers
	// assumptions: all imports  are in pkgs
	//   there may be cycles
	//   no nested packages
	//   imports are non transitive
	//	 entities are declared out of order and may have cyclic deps
	//   if a package imports 2 packages that export the same name it is an error
	//	  (here we assume this has already been checked for)
	//    (resolve will actually resolve them, hiding the error)
	
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

