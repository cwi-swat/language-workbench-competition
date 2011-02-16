module languages::packages::syntax::Packages

import languages::entities::syntax::Entities;
import languages::entities::syntax::Layout;
import languages::entities::syntax::Types;
import languages::entities::syntax::Ident;

start syntax Package
	= package: "package" Ident "{" Import* Entities "}";

syntax Import
	= imp: "import" Ident;
