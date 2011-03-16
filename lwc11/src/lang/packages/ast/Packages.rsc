module lang::packages::ast::Packages

import lang::entities::ast::Entities;

data Package 
	= package(str name, list[Import] imports, Entities entities);
	
data Import 
	= imp(str name); 

// Extension

data Name
	= qualified(str pkg, str name);
	
anno loc Package@location;
anno loc Import@location;
anno loc Name@location;

