module lang::packages::compile::Package2Java

import List;	

import lang::packages::ast::Packages;
extend lang::entities::compile::Entities2Java;

public str package2java(Package pkg) {
	return "package <pkg.name>;
           '<for (i <- pkg.imports) {>
           'import <i.name>.*;
           '<}>
           '<intercalate("\n", entities2java(pkg.entities))>";
}

public str type2java(qualified(str pkg, str name)) = "<pkg>.<name>";