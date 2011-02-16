module languages::entities::utils::Parse

import languages::entities::syntax::Entities;
import languages::entities::ast::Entities;
import ParseTree;

public languages::entities::ast::Entities::Entities parse(loc file) {
	pt = parse(#languages::entities::syntax::Entities::Entities, file);
	return implode(#languages::entities::ast::Entities::Entities, pt);
}