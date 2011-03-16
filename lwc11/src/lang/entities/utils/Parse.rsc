module lang::entities::utils::Parse

import lang::entities::syntax::Entities;
import lang::entities::syntax::Types;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Layout;

import lang::entities::ast::Entities;
import ParseTree;

public lang::entities::ast::Entities::Entities parse(loc file) {
	return implode(#lang::entities::ast::Entities::Entities, parseTree(file));
}

public lang::entities::syntax::Entities::Entities parseTree(loc file) {
	return parse(#lang::entities::syntax::Entities::Entities, file);
}
