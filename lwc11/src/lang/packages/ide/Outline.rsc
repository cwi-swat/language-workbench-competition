module lang::packages::ide::Outline

import lang::entities::ide::Outline;
import lang::packages::syntax::Packages;

import ParseTree; // for loc annos

data Node
	= imports(list[Node] nodes)
	| \import()
	;
	
	
public Node outlinePackage(Package pkg) {
	return outline([
		imports([\import()[@label="<i.name>"][@\loc=i@\loc] | /Import i := pkg])[@label="Imports"],
		outlineEntities(pkg.entities)
	])[@label="<pkg.name>"];
}
