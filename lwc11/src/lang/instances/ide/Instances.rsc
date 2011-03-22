module lang::instances::ide::Instances

import lang::instances::check::Instances;
import lang::instances::syntax::Instances;

import lang::instances::ide::Outline;
import lang::instances::ide::Links;
import lang::instances::utils::Parse;
import lang::instances::utils::Implode;

import List;
import ParseTree;
import util::IDE;

public str INSTANCES_LANGUAGE = "Instances";
public str INSTANCES_EXTENSION = "instances";


public void registerInstances() {
	registerLanguage(INSTANCES_LANGUAGE, "instances", parseInstances);
  	registerOutliner(INSTANCES_LANGUAGE, outlineInstances);
  	registerAnnotator(INSTANCES_LANGUAGE, annotateWithLinks);
  	registerAnnotator(INSTANCES_LANGUAGE, checkAndAnnotatePT);
}

private Instances checkAndAnnotatePT(Instances pt) {
  	return pt[@messages = toSet(check(|project://lwc11/input|,implode(pt)))];
}