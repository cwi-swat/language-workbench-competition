module lang::instances::ast::Instances

import lang::entities::ast::Entities; // for Name

data Instances
	= instances(list[Require] requires, list[Instance] instances);

data Require
	= require(str name);

data Instance
	= instance(Name \type, Name name, list[Assign] assigns);
	
data Assign
	= assign(str name, Value \value);

data Value
	= date(int day, int month, int year)
	| string(str strValue)
	| integer(int intValue)
	| boolean(bool boolValue)
	| reference(Name name);

anno loc Instances@location;
anno loc Instance@location;
anno loc Assign@location;
anno loc Value@location;
