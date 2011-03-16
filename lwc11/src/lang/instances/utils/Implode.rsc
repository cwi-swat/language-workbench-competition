module lang::instances::utils::Implode

import lang::instances::syntax::Instances;
import lang::instances::ast::Instances;

import ParseTree;

public lang::instances::ast::Instances::Instances implode(lang::instances::syntax::Instances::Instances pt) {
	return implode(#lang::instances::ast::Instances::Instances, pt);
}
