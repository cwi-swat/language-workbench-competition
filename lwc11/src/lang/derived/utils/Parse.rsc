module lang::derived::utils::Parse

import lang::derived::syntax::Derived;
import lang::instances::syntax::Values;

import lang::entities::syntax::Entities;
import lang::entities::syntax::Types;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Layout;

import ParseTree;


public lang::entities::syntax::Entities::Entities parseEntities(loc file) {
	return parse(#lang::entities::syntax::Entities::Entities, file);
}

public lang::entities::syntax::Entities::Entities parseEntities(str x, loc file) {
	return parse(#lang::entities::syntax::Entities::Entities, x, file);
}
