module languages::packages::utils::Load

import languages::packages::utils::Parse;
import languages::packages::ast::Packages;

import IO;

public str EXT = "package";

public map[str, Package] load(loc path, str name) {
	todo = {name};
	table = ();	
	while (p <- todo, p notin table) {
		pkg = parse(path, p);
		table[p] = pkg;
		todo += { i | imp(i) <- pkg.imports } ;
		todo -= {p};
	}
	return table;
}

Package parse(loc path, str name) {
	return parse(|<path.scheme>://<path.host>/<path.path>/<name>.<EXT>|);
}