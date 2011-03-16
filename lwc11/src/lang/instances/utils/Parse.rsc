module lang::instances::utils::Parse

import lang::instances::syntax::Instances;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;
import lang::entities::syntax::Layout;

import lang::instances::ast::Instances;
import ParseTree;

public lang::instances::ast::Instances::Instances parse(loc file) {
	pt = parse(#lang::instances::syntax::Instances::Instances, file);
	return implode(#lang::instances::ast::Instances::Instances, pt);
}