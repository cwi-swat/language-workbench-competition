module languages::entities::check::Entities

import languages::entities::ast::Entities;
import Message;
import Relation;

public list[Message] check(Entities es) {
	defs = {};
	errors = for (e <- es.entities) {
		if (e.name in defs) {
			append error("Redeclaration of entity <nameStr(e.name)>", e@location);
		}
		defs += {e.name};
	}
	
	return ( errors | it + checkEntity(e, defs) | e <- es.entities );
}


public list[Message] checkEntity(Entity e, set[Name] defs) {
	fs = {};
	return for (f <- e.fields) {
		if (f.name in fs) {
			append error("Duplicate field <f.name> in <nameStr(e.name)>", f@location);
		}
		if (reference(Name n) := f.\type, n notin defs) {
		  	append error("Field <nameStr(e.name)>.<f.name> references undefined entity <nameStr(n)>", n@location);
		}
		fs += {f.name};
	}
}


public str nameStr(name(str n)) = n;
