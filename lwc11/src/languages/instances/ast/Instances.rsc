module languages::instances::ast::Instances

import languages::entities::ast::Entities; // for Name

data Instances
	= instances(list[Instance] instances);
	
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
