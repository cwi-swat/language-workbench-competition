module languages::entities::utils::Load

import languages::entities::ast::Entities;
import languages::entities::utils::Parse;
import languages::entities::ide::Entities;

public Entities load(loc path, str name) {
	return parse(entitiesPath(path, name));
}

// TODO: factor out generic function
loc entitiesPath(loc path, str name) {
	return |<path.scheme>://<path.host>/<path.path>/<name>.<ENTITIES_EXTENSION>|;
}