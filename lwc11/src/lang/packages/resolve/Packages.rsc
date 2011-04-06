module lang::packages::resolve::Packages

import lang::packages::ast::Packages;
import lang::entities::ast::Entities;
import lang::packages::check::Packages;
import lang::packages::utils::Load;

import IO;

// replace all identifiers with long identifiers
// assumptions: all imports  are in pkgs
//   there may be cycles
//   no nested packages
//   imports are non transitive
//	 entities are declared out of order and may have cyclic deps
//   if a package imports 2 packages that export the same name it is an error
//	  (here we assume this has already been checked for)
//    (resolve will actually resolve them, hiding the error)
	

public WorkingSet resolve(WorkingSet pkgs) {
	return { <k, success(l, resolvePkg(pkg, pkgs))> | <k, success(l, pkg)> <- pkgs };
}

private Package resolvePkg(Package pkg, WorkingSet pkgs) {
	imps = imports(pkg) + {pkg.name};
	return visit (pkg) {
		case Name n:name(str x) => qualified(ip.name, x)[@location=n@location]
		     when i <- imps, <i, success(_, Package ip)> <- pkgs, x in exports(ip)
	}
}

