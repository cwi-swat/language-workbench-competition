module lang::packages::compile::Package2XML

import lang::packages::ast::Packages;
import lang::entities::compile::Entities2XML;

import XMLDOM;

public Node package2xml(Package p) {
	return document(element(none(), "package",
		[attribute(none(), "name", p.name)]
		+ [ import2element(i) | i <- p.imports ]
		+ [entities2xml(p.entities).root]));
}

public Node import2element(Import i) {
	return element(none(), "import", [attribute(none(), "name", i.name)]);
}