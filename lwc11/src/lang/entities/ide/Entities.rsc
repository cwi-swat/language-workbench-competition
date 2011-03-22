module lang::entities::ide::Entities

import lang::entities::syntax::Entities;
import lang::entities::check::Entities;
import lang::entities::ide::Outline;
import lang::entities::utils::Parse;
import lang::entities::utils::Implode;
import lang::entities::compile::Entities2Java;
import lang::entities::compile::Entities2XML;

import util::IDE;
import List;
import XMLDOM;
import IO;
import Message;
import ParseTree;

public str ENTITIES_EXTENSION = "entities";
public str ENTITIES_LANGUAGE = "Entities";

public void generateJava(Entities pt, loc l) {
	for (<name, class> <- entities2java(implode(pt))) {
		writeFile(|project://lwc11/output/<name>.java|, class);
	}
}

public void generateXML(Entities pt, loc l) {
	xml = entities2xml(implode(pt));
	println(l.path);
	if (/\/<base:[a-zA-Z0-9_]+>\.entities$/ := l.path) {
		println("outputting to: <base>.xml");
		writeXMLPretty(|project://lwc11/output/<base>.xml|, xml);
	}
}


public void registerEntities() {
	contribs = {
		popup(
			menu(ENTITIES_LANGUAGE,[
	//    		edit("Format", formatModule), 
	    		action("Generate Java", generateJava), 
	    		action("Generate XML", generateXML) 
		    ])
	  	)
	};
	
  	registerLanguage(ENTITIES_LANGUAGE, ENTITIES_EXTENSION, parseEntities);
  	registerAnnotator(ENTITIES_LANGUAGE, checkAndAnnotatePT);
	registerOutliner(ENTITIES_LANGUAGE, outlineEntities);
	registerContributions(ENTITIES_LANGUAGE, contribs);
}   

private Entities checkAndAnnotatePT(Entities pt) {
  	return pt[@messages = toSet(check(implode(pt)))];
}

