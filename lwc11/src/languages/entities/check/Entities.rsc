module languages::entities::check::Entities

import languages::entities::ast::Entities;
import Relation;

public list[str] check(Entities es) {
	defs = {};
	errors = for (e <- es.entities) {
		if (e.name in defs) {
			append "Redeclaration of entity <e.name>";
		}
		defs += {e.name};
	}
	for (e <- es.entities) {
	  errors += checkEntity(e, defs);
	}
	return errors; 
}


public list[str] checkEntity(Entity e, set[str] defs) {
	fs = {};
	return for (f <- e.fields) {
		if (f.name in fs) {
			append "Duplicate field <f.name> in <e.name>";
		}
		if (reference(str n) := f.\type, n notin defs) {
		  	append "Field <e.name>.<f.name> references undefined entity <n>";
		}
		fs += {f.name};
	}
}