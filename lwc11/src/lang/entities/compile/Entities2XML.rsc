module lang::entities::compile::Entities2XML

import lang::entities::ast::Entities;

import Node;
import XMLDOM;

public Node entities2xml(Entities es) {
	return document(element(none(), "entities", 
	   [ entity2element(e) | e <- es.entities ]));
}

public Node entity2element(Entity e) {
	a = attribute(none(), "name", e.name.name);
	return element(none(), "entity", 
	   [a, [ field2element(f) | f <- e.fields ]]); 
}

public Node field2element(Field f) {
	attrs = [attribute(none(), "name", f.name)];
	if (primitive(t) := f.\type) {
		attrs += [attribute(none(), "type", getName(t))];
	}
	else {
		attrs += [attribute(none(), "type", "ref"),
					attribute(none(), "references", f.\type.name.name)];
	}
	return element(none(), "field", attrs); 
}