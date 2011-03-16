module lang::database::ast::Database

data Database 
	= database(list[Table] tables);

data Table
	= table(str name, list[Column] columns);

data Column
	= column(str name, ColumnType \type, list[Constraint] constraints);

data ColumnType
	= integer()
	| boolean()
	| varchar()
	| date()
	| text();
	
data Constraint
	= unique()
	| key()
	| notNull()
	| references(str table, str column);


	
 