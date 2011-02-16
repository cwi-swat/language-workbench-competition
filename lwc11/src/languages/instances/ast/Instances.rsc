module languages::instances::ast::Instances

data Instances
	= instances(list[Instance] instances);
	
data Instance
	= instance(str \type, str name, list[Assign] assigns);
	
data Assign
	= assign(str name, Value \value);

data Value
	= date(int day, int month, int year)
	| string(str strValue)
	| integer(int intValue)
	| boolean(bool boolValue)
	| reference(str name);
