module lang::packages::check::Packages

import lang::packages::ast::Packages;
extend lang::entities::check::Entities;

import lang::packages::utils::Load;
import lang::packages::resolve::Packages;

import Message;
import Relation;
import IO;
import Map;

public str nameStr(qualified(str pkg, str n)) = n;

public list[Message] check(loc path, Package pkg) {
	return resolveAndCheck(loadAll(path, pkg));
}

public list[Message] check(loc path, str name) {
	WorkingSet ws = load(path, name);
	return resolveAndCheck(ws);
}

public list[Message] resolveAndCheck(WorkingSet ws) {
	errors = check(ws);
	ws = resolve(ws);
	es = [ e | /success(_, pkg) := ws, /Entity e := pkg ];
	ent = entities(es);
	return errors + check(ent);
}


public list[Message] check(WorkingSet pkgs) {
	// can assume that all imported packagenames of all packages
	// are in the domain of pkgs. (this follows from Load)
	
	errors = [ error("Qualified name does not correspond to package name", q@location) 
				| <p1, success(_, pkg)> <- pkgs,  /entity(q:qualified(p2, n2), _) <- pkg, p2 != p1 ];  
				  
	// TODO: check that package name corresponds to filename
				
	return ( errors | it + checkImports(pkg, pkgs) | <n, success(_, pkg)> <- pkgs);
}

public list[Message] checkImports(Package pkg, WorkingSet pkgs) {
	names = { <n, pkg.name> | n <- exports(pkg) };
	list[Message] errors = [];
	for (/imp(i) <- pkg, <i, success(_, pkg2)> <- pkgs) {
		pkg2names = exports(pkg2);
		for (n <- domain(names)) {
			overlap = domain(names) & pkg2names; 
			errors += [ error("Name collision: <ov> exported from both <pkg2.name> and <p3>", pkg@location) 
							| ov <- overlap, <n, p3> <- names ];
		}
		names += { <n, pkg2.name> | n <- pkg2names };
	}
	for (/i:imp(n) <- pkg, <n, notFound()> <- pkgs) {
		errors += [ error("Unresolved import", i@location)]; 
	}
	return errors;
}

public set[str] imports(Package pkg) {
	return { n | /imp(n) <- pkg };
}

public set[str] exports(Package pkg) {
	return { n | /entity(name(n), _) <- pkg };
} 
