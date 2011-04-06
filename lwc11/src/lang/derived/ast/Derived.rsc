module lang::derived::ast::Derived

extend lang::entities::ast::Entities;
extend lang::instances::ast::Values;

data Field
	= derived(Type \type, str name, Expression exp)
	| annotated(Annotation annotation, Type \type, str name)
	;
	
data Annotation
	= host(str string)
	;

data Expression
	= const(Value val)
	| field(str name)
	| neg(Expression arg)
	| mul(Expression lhs, Expression rhs)
	| div(Expression lhs, Expression rhs)
	| add(Expression lhs, Expression rhs)
	| sub(Expression lhs, Expression rhs)
	;
