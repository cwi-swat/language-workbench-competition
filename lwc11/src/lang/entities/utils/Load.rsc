module lang::entities::utils::Load

import lang::entities::ast::Entities;
import lang::entities::utils::Parse;
import lang::entities::ide::Entities;

public Entities load(loc path, str name) {
	return parse(entitiesPath(path, name));
}

// TODO: factor out generic function
loc entitiesPath(loc path, str name) {
	return |<path.scheme>://<path.host>/<path.path>/<name>.<ENTITIES_EXTENSION>|;
}