module lang::packages::utils::Load

import lang::packages::utils::Parse;
import lang::packages::ast::Packages;

import IO;

public str EXT = "package";

data LoadResult
	= notFound(set[Package] offenders)
	| success(loc file, Package package);

alias WorkingSet = map[str pkgName, LoadResult result];

// a map from packagename to the set of packages that import it.
alias Todo = map[str, set[Package]];

public WorkingSet loadAll(loc path, Package pkg) {
	return (pkg.name: success(pkg@location, pkg)) + loadPackages(path, (r: pkg | r <- requiredPackages(pkg)));
}

public WorkingSet load(loc path, str name) {
	return loadPackages(path, (name: {}));	
}

public WorkingSet loadPackages(loc path, Todo todo) {
	ws = ();	
	set[Package] empty = {};
	while (p <- todo, p notin ws) {
		ppath = packagePath(path, p);
		if (exists(ppath)) {
			pkg = parse(ppath);
			ws[p] = success(ppath, pkg);
			for (r <- requiredPackages(pkg)) {
				todo[r]?empty += {pkg};
			}
		}
		else {
			ws[p] = notFound(todo[p]);
		}		
		todo -= (p: {});
	}
	return ws;
}

loc packagePath(loc path, str name) {
	return |<path.scheme>://<path.host>/<path.path>/<name>.<EXT>|;
}

public set[str] requiredPackages(Package pkg) {
	return { i.name | Import i <- pkg.imports } + { q.pkg | /q:qualified(_, _) <- pkg };
}


