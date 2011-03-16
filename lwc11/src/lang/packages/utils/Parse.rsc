module languages::packages::utils::Parse

import languages::packages::ast::Packages;
import languages::packages::syntax::Packages;
import languages::entities::syntax::Entities;
import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;

import ParseTree;

public languages::packages::ast::Packages::Package parse(loc file) {
	return implode(#languages::packages::ast::Packages::Package,
			parse(#languages::packages::syntax::Packages::Package, file));
}
