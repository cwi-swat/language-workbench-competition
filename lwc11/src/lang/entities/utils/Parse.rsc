module languages::entities::utils::Parse

import languages::entities::syntax::Entities;
import languages::entities::syntax::Types;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Layout;

import languages::entities::ast::Entities;
import ParseTree;

public languages::entities::ast::Entities::Entities parse(loc file) {
	return implode(#languages::entities::ast::Entities::Entities, parseTree(file));
}

public languages::entities::syntax::Entities::Entities parseTree(loc file) {
	return parse(#languages::entities::syntax::Entities::Entities, file);
}
