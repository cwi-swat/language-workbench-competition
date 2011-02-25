module languages::derived::ast::Derived

import languages::entities::ast::Entities;

data Field
	= derived(Type \type, str name, Expression exp);

data Expression
	= nat(int intValue)
	| field(str name)
	| neg(Expression arg)
	| mul(Expression lhs, Expression rhs)
	| div(Expression lhs, Expression rhs)
	| add(Expression lhs, Expression rhs)
	| sub(Expression lhs, Expression rhs)
	;
