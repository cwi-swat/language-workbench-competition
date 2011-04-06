module lang::instances::ast::Values

data Value
	= date(int day, int month, int year)
	| string(str strValue)
	| integer(int intValue)
	| float(real floatValue)
	| boolean(bool boolValue);
