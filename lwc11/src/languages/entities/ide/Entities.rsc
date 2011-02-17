module languages::entities::ide::Entities

import SourceEditor;
import languages::entities::syntax::Entities;
import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;

import languages::entities::check::Entities;
import languages::entities::ast::Entities;

import List;
import ParseTree;

public str ENTITIES_EXTENSION = "entities";

public void registerEntities() {
  registerLanguage("Entities", ENTITIES_EXTENSION, Tree (str x) {
    return parse(#languages::entities::syntax::Entities::Entities, x);
  });

/* 
  // This causes an infinite loop currently; the markers trigger a document change
  registerAnnotator("Entities", languages::entities::syntax::Entities::Entities (languages::entities::syntax::Entities::Entities input) {
  		Tree pt = input;
  		ast = implode(#languages::entities::ast::Entities::Entities, pt);
  		errors = check(ast);
  		pt@messages = toSet(errors);
  		return pt;
	}
  );
*/
}