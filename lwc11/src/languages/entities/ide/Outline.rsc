module languages::entities::ide::Outline

import languages::entities::syntax::Entities;

import ParseTree; // for loc annos

data Node
	= outline(list[Node] nodes)
	| entity(list[Node] nodes)
	| field()
	;	 

anno loc Node@\loc;
anno str Node@label;

public Node outlineEntities(Entities x) {
	return outline([ outlineEntity(e) | /Entity e := x ])[@label="Entities"]; 
}

public Node outlineEntity(Entity e) {
	fs = [ field()[@label="<f.name>"][@\loc=f@\loc] | /Field f := e ]; 
	return entity(fs)[@label="<e.name>"][@\loc=e@\loc];
}


