module languages::packages::resolve::Packages

import languages::packages::ast::Packages;
import languages::entities::ast::Entities;

public Entities resolve(map[str, Package] pkgs) {
	// replace all identifiers with long identifiers
	// assumptions: all imports  are in pkgs
	//   there may be cycles
	//   no nested packages
	//   imports are non transitive
	//	 entities are declared out of order and may have cyclic deps
	//   if a package imports 2 packages that export the same name it is an error
	//	  (here we assume this has already been checked for)
	
	// approach:
	//   encounter a defined name: qualify it with pkg we're in
	//    put it in a table for this pkg (shortname -> longname)
	// then: a used name is looked up in the table for the current pkg
	//   if not found, chase imports of pkg to find
	
	//map[str, set[str]] import
}


public set[str] imports(Package pkg) {
	return { n | /imp(n) <- pkg };
}

public set[str] exports(Package pkg) {
	return { n | /entity(n, _) <- pkg };
} 