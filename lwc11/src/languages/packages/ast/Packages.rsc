module languages::packages::ast::Packages

import languages::entities::ast::Entities;

data Package 
	= package(str name, list[Import] imports, Entities entities);
	
data Import 
	= imp(str name); 

