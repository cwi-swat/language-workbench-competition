module lang::entities::ide::Check

import lang::entities::ast::Entities;
import lang::entities::syntax::Entities;
import lang::entities::check::Entities;
import List;

import ParseTree;

public languages::entities::syntax::Entities::Entities checkAndAnnotatePT(languages::entities::syntax::Entities::Entities input) {
  	Tree pt = input;
  	ast = implode(#languages::entities::ast::Entities::Entities, pt);
  	errors = check(ast);
  	pt@messages = toSet(errors);
  	return pt;
}
