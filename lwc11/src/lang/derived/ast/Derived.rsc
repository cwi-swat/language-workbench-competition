module lang::derived::ast::Derived

import lang::entities::ast::Entities;

data Field
	= derived(Type \type, str name, Expression exp)
	| annotated(Annotation annotation, Type \type, str name)
	;
	
data Annotation
	= annotation(str name, str string)
	;

data Expression
	= nat(int intValue)
	| field(str name)
	| neg(Expression arg)
	| mul(Expression lhs, Expression rhs)
	| div(Expression lhs, Expression rhs)
	| add(Expression lhs, Expression rhs)
	| sub(Expression lhs, Expression rhs)
	;
