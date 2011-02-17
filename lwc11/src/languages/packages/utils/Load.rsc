module languages::packages::utils::Load

import languages::packages::utils::Parse;
import languages::packages::ast::Packages;

import IO;

public str EXT = "package";

data LoadResult
	= notFound(set[Package] offenders)
	| success(loc file, Package package);


// a map from package to a set of package that import it.
alias Todo = map[str, set[Package]];

public map[str, LoadResult] loadAll(loc path, Package pkg) {
	return (pkg.name: success(pkg@location, pkg)) + loadPackages(path, (r: pkg | r <- requiredPackages(pkg)));
}

public map[str, LoadResult] load(loc path, str name) {
	return loadPackages(path, (name: {}));	
}

public map[str, LoadResult] loadPackages(loc path, Todo todo) {
	table = ();	
	set[Package] empty = {};
	while (p <- todo, p notin table) {
		ppath = packagePath(path, p);
		if (exists(ppath)) {
			pkg = parse(ppath);
			table[p] = success(ppath, pkg);
			for (r <- requiredPackages(pkg)) {
				todo[r]?empty += {pkg};
			}
		}
		else {
			table[p] = notFound(todo[p]);
		}		
		todo -= (p: {});
	}
	return table;
}

loc packagePath(loc path, str name) {
	return |<path.scheme>://<path.host>/<path.path>/<name>.<EXT>|;
}

//public rel[str, loc] requiredPackages(Package pkg) {
//	return { <i.name, i@location> | Import i <- pkg.imports } + { <q.pkg, q@location> | /q:qualified(_, _) <- pkg };
//}

public set[str] requiredPackages(Package pkg) {
	return { i.name | Import i <- pkg.imports } + { q.pkg | /q:qualified(_, _) <- pkg };
}


