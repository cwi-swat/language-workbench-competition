module languages::entities::check::Entities

import languages::entities::ast::Entities;
import Message;
import Relation;

public list[Message] check(Entities es) {
	defs = {};
	errors = for (e <- es.entities) {
		if (e.name in defs) {
			append error("Redeclaration of entity <e.name>", e@location);
		}
		defs += {e.name};
	}
	
	return ( errors | it + checkEntity(e, defs) | e <- es.entities );
}


public list[Message] checkEntity(Entity e, set[str] defs) {
	fs = {};
	return for (f <- e.fields) {
		if (f.name in fs) {
			append error("Duplicate field <f.name> in <e.name>", f@location);
		}
		if (reference(str n) := f.\type, n notin defs) {
		  	append error("Field <e.name>.<f.name> references undefined entity <n>", f@location);
		}
		fs += {f.name};
	}
}