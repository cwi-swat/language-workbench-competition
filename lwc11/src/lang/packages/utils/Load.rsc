module lang::packages::utils::Load

import lang::packages::ast::Packages;
import lang::packages::utils::Parse;
import lang::packages::utils::Implode;

import IO;
import Set;

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

public WorkingSet loadPackages(loc searchPath, set[str] todo) {
	ws = {};	
	while (todo != {}) {
		<p, todo> = takeOneFrom(todo);
		path = packagePath(searchPath, p);
		LoadResult lr;
		try {
			pkg = implode(parsePackage(path));
			lr = success(path, pkg);
			todo += requiredPackages(pkg) - ws<0>;
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


