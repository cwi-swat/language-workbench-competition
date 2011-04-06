module lang::packages::compile::Package2Java

import List;	

import lang::packages::ast::Packages;
extend lang::entities::compile::Entities2Java;

public rel[str, str] package2java(Package pkg) {
	return { <"<pkg.name>.<e.name.name>", packagedEntity2Java(pkg, e)> | e <- pkg.entities.entities };
}

public str packagedEntity2Java(Package pkg, Entity e) {
	return "package <pkg.name>;
           '<for (i <- pkg.imports) {>
           'import <i.name>.*;
           '<}>
           '<entity2java(e)>";
}

public str type2java(reference(qualified(str pkg, str name))) = "<pkg>.<name>";