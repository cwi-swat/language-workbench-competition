module languages::entities::render::Entities

import languages::entities::ast::Entities;
import vis::Figure;
import IO;


public Figure entities2figure(Entities es) {
	nodes = [ entity2figure(e) | e <- es.entities ];
	println(nodes);
	arrow = triangle(5);
	edges = [ edge(name2id(e.name), name2id(n), arrow) | e <- es.entities, /reference(n) := e ];
	println(edges);
	return graph(nodes, edges, hint("layered"), size(400));
}

public Figure triangle(int side){
  return shape([vertex(0,0), vertex(side/2,2*side), vertex(side, 0)], shapeClosed(), fillColor("red"));
}

public Figure entity2figure(Entity e) {
	rows = [box(text(e.name.name), fontSize(12))] 
				+ [ field2figure(f) | f <- e.fields ];
	
	return box(vcat(rows), id(name2id(e.name)), size(0));
}

public Figure field2figure(Field f) {
	return hcat([text(type2str(f.\type)), text(f.name)], hgap(5));
}

public str name2id(Name n) {
	return "<n>";
}

public str type2str(Type t) {
	switch (t) {
		case primitive(string()): 	return "string"; 
     	case primitive(date()): 	return "date";
     	case primitive(integer()): 	return "integer";
     	case primitive(boolean()): 	return "boolean";
     	case reference(Name n): 	return n.name;
     	default: throw "Unhandled type: <t>";	
	}
}