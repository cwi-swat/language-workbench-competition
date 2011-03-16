module languages::derived::utils::Parse

import languages::derived::syntax::Derived;
import languages::entities::syntax::Entities;
import languages::entities::syntax::Types;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Layout;

import languages::derived::ast::Derived;
import languages::entities::ast::Entities;

import ParseTree;

public languages::entities::ast::Entities::Entities parse(loc file) {
	pt = parse(#languages::entities::syntax::Entities::Entities, file);
	return implode(#languages::entities::ast::Entities::Entities, pt);
}