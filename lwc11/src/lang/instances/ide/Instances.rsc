module lang::instances::ide::Instances


import lang::instances::syntax::Instances;
import lang::entities::syntax::Layout;
import lang::entities::syntax::Ident;

import lang::instances::check::Instances;
import lang::instances::ast::Instances;
import lang::entities::ast::Entities;

import lang::instances::ide::Outline;
import lang::instances::ide::Links;


import List;
import ParseTree;
import SourceEditor;



public void registerInstances() {
  registerLanguage("Instances", "instances", Tree (str x, loc l) {
    	return parse(#lang::instances::syntax::Instances::Instances, x, l);
  });
  registerOutliner("Instances", outlineInstances);
  registerAnnotator("Instances", annotateWithLinks);

/*  
  registerAnnotator("Instances", lang::instances::syntax::Instances::Instances (lang::instances::syntax::Instances::Instances input) {
  		Tree pt = input;
  		ast = implode(#lang::instances::ast::Instances::Instances, pt);
  		errors = check(ast, entities([]));
  		pt@messages = toSet(errors);
  		return pt;
	}
  );
*/
}