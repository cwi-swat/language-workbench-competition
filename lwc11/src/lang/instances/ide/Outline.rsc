module lang::instances::ide::Outline

import lang::instances::syntax::Instances;

import ParseTree; // for loc annos

data Node
	= outline(list[Node] nodes)
	| requires(list[Node] nodes)
	| require()
	| instance(list[Node] nodes)
	| assign()
	;
	
anno loc Node@\loc;
anno str Node@label;
	
public Node outlineInstances(Instances is) {
	return outline([
		requires([require()[@label="<r.name>"][@\loc=r@\loc] | /Require r := is.requires])[@label="Requires"],
		outline([ outlineInstance(i) | /Instance i := is ])[@label="Instances"]
	]);
}

public Node outlineInstance(Instance i) {
	as = [ assign()[@label="<a>"][@\loc=a@\loc] | /Assign a := i ]; 
	return instance(as)[@label="<i.entity> <i.name>"][@\loc=i@\loc];
}


