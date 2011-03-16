module lang::instances::utils::Parse

import lang::instances::syntax::Instances;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;
import lang::entities::syntax::Layout;

import ParseTree;

public lang::instances::syntax::Instances::Instances parseInstances(loc file) {
	return parse(#lang::instances::syntax::Instances::Instances, file);
}

public lang::instances::syntax::Instances::Instances parseInstances(str x, loc file) {
	return parse(#lang::instances::syntax::Instances::Instances, x, file);
}
