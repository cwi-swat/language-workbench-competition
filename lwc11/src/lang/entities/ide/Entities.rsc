module lang::entities::ide::Entities

import lang::entities::syntax::Entities;
import lang::entities::check::Entities;
import lang::entities::ide::Outline;
import lang::entities::utils::Parse;
import lang::entities::utils::Implode;
import lang::entities::compile::Entities2Java;
import lang::entities::compile::Entities2XML;
import lang::entities::transform::Entities2Database;
import lang::database::compile::Database2SQL;

import util::IDE;
import List;
import XMLDOM;
import IO;
import Message;
import ParseTree;


public void generateJava(Entities pt, loc l) {
	for (<name, class> <- entities2java(implode(pt))) {
		writeFile(|project://lwc11/output/<name>.java|, class);
	}
}

private str baseName(loc l) {
	if (/\/<base:[a-zA-Z0-9_]+>\.entities$/ := l.path) {
		return base;
	}
	throw "Could not match basename in <l.path>";
}

public void generateXML(Entities pt, loc l) {
	xml = entities2xml(implode(pt));
	writeXMLPretty(|project://lwc11/output/<baseName(l)>.xml|, xml);
}

public void generateSQL(Entities pt, loc l) {
	sql = database2sql(entities2database(implode(pt)));
	writeFile(|project://lwc11/output/<baseName(l)>.sql|, sql);
}

public str ENTITIES_EXTENSION = "entities";
public str ENTITIES_LANGUAGE = "Entities";


public void registerEntities() {
	contribs = {
		popup(
			menu(ENTITIES_LANGUAGE,[
	    		action("Generate Java", generateJava), 
	    		action("Generate XML", generateXML), 
	    		action("Generate SQL", generateSQL) 
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

