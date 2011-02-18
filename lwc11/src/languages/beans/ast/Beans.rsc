module languages::beans::ast::Beans

data Bean
	= bean(str name, list[Attribute] attributes, list[Accessor] accessors);

data Attribute
	= attribute(str name, str \type);

data Accessor
	= setter(str name, str \type)
	| getter(str name, str \type);
	
