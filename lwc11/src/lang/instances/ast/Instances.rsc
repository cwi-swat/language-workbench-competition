module lang::instances::ast::Instances

import lang::entities::ast::Entities; // for Name
extend lang::instances::ast::Values;

data Instances
	= instances(list[Require] requires, list[Instance] instances);

data Require
	= require(str name);

data Instance
	= instance(Name \type, Name name, list[Assign] assigns);
	
data Assign
	= assign(str name, Expression exp);

data Expression
	= const(Value val)
	| reference(Name name);


anno loc Instances@location;
anno loc Instance@location;
anno loc Assign@location;
anno loc Expression@location;
