module lang::packages::utils::Load

import lang::packages::utils::Parse;
import lang::packages::ast::Packages;

import IO;

public str EXT = "package";

data LoadResult
	= notFound()
	| success(loc file, Package package);

alias WorkingSet = rel[str pkgName, LoadResult result];

public WorkingSet loadAll(loc path, Package pkg) {
	return {<pkg.name, success(pkg@location, pkg)>,
			loadPackages(path, {r | r <- requiredPackages(pkg)})};
}

public WorkingSet load(loc path, str name) {
	return loadPackages(path, {name});	
}

public WorkingSet loadPackages(loc searchPath, Todo todo) {
	ws = {};	
	while (todo != {}) {
		<p, todo> = takeOneFrom(todo);
		path = packagePath(searchPath, p);
		try {
			pkg = parse(path);
			lr = success(path, pkg);
			todo += reguiredPackages(pkg) - domain(ws);
		}
		catch PathNotFound(_): {
			lr = notFound(path);
		}
		ws += {<p, lr>};		
		todo -= {p};
	}
	return ws;
}

loc packagePath(loc path, str name) {
	return |<path.scheme>://<path.host>/<path.path>/<name>.<EXT>|;
}

public set[str] requiredPackages(Package pkg) {
	return { i.name | Import i <- pkg.imports } + { q.pkg | /q:qualified(_, _) <- pkg };
}


