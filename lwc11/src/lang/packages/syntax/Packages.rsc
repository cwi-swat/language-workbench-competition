module lang::packages::syntax::Packages

import lang::entities::syntax::Entities;
import lang::entities::syntax::Layout;
import lang::entities::syntax::Types;
import lang::entities::syntax::Ident;

start syntax Package
	= package: "package" Ident name "{" Import* imports Entities entities "}";

syntax Import
	= imp: "import" Ident name;

// Extension
syntax Name
	= qualified: Ident "." Ident;