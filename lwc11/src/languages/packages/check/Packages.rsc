module languages::packages::check::Packages

import languages::packages::ast::Packages;
import languages::entities::ast::Entities; // for anno on Name
import languages::packages::utils::Load;

import Message;
import Relation;
import IO;

public list[Message] check(map[str, LoadResult] pkgs) {
	// can assume that all imported packagenames of all packages
	// are in the domain of pkgs. (this follows from Load)
	
	errors = [ error("Could not find package <n> imported by <p.name>", p@location) 
				| n <- pkgs, notFound(off) := pkgs[n], p <- off ];
				
	errors += [ error("Declaration of qualified name <p2>.<n2> that does not correspond to package name <n>", q@location) 
				| n <- pkgs, success(_, pkg) := pkgs[n],  
				  /entity(q:qualified(p2, n2), _) <- pkg, p2 != n ];  
				
	return ( errors | it + checkImports(pkg, pkgs) | n <- pkgs, success(_, pkg) := pkgs[n]);
}

public list[Message] checkImports(Package pkg, map[str, LoadResult] pkgs) {
	names = { <n, pkg.name> | n <- exports(pkg) };
	list[Message] errors = [];
	for (i <- imports(pkg), success(_, pkg2) := pkgs[i]) {
		pkg2names = exports(pkg2);
		for (n <- domain(names)) {
			overlap = domain(names) & pkg2names; 
			errors += [ error("Name collision in <pkg.name>: <ov> exported from both <pkg2.name> and <p3>", pkg@location) 
							| ov <- overlap, p3 <- names[n] ];
		}
		names += { <n, pkg2.name> | n <- pkg2names };
	}
	return errors;
}

public set[str] imports(Package pkg) {
	return { n | /imp(n) <- pkg };
}

public set[str] exports(Package pkg) {
	return { n | /entity(name(n), _) <- pkg };
} 
