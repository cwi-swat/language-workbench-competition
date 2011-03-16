module lang::packages::compile::Package2Java

import lang::packages::ast::Packages;
import lang::entities::ast::Entities;
import lang::entities::compile::Entities2Java;

import List;	

public str package2java(Package pkg) {
	return "package <pkg.name>;
           '<for (i <- pkg.imports) {>
           'import <i.name>.*;
           '<}>
           '<intercalate("\n", entities2java(pkg.entities))>";
}


// TODO: need extend! Entities2Java does not see this.
public str type2java(qualified(str pkg, str name)) = "<pkg>.<name>";