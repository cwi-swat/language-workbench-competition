module languages::entities::ide::Check

import languages::entities::ast::Entities;
import languages::entities::syntax::Entities;
import languages::entities::check::Entities;

import ParseTree;

public languages::entities::syntax::Entities::Entities checkAndAnnotatePT(languages::entities::syntax::Entities::Entities input) {
  	Tree pt = input;
  	ast = implode(#languages::entities::ast::Entities::Entities, pt);
  	errors = check(ast);
  	pt@messages = toSet(errors);
  	return pt;
}
