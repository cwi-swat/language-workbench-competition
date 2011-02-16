module languages::database::compile::Database2SQL

import languages::database::ast::Database;

public str database2sql(Database db) {
	return "
<for (t <- db.tables) {>
<table2sql(t)>
<}>
";
}

public str table2sql(Table t) {
	cols = [ column2sql(c) | c <- t.columns ];
	return "
create table <t.name> (
<intercalate(",\n", cols)>
)	
";
}

public str column2sql(Column c) {
	return "<c.name> <type2sql(c.\type)> <intercalate(", ", [ constraint2sql(cons) | cons <- constraints ])>";
}

public str type2sql(ColumnType t) {
	switch (t) {
		case integer(): return "int";
		case boolean(): return "bool";
		case varchar(): return "varchar";
		case date(): return "date";
		case text(): return "text";
		default: throw "Unhandled colummn type: <t>";
	}
}


public str constraint2sql(Constraint c) {
	switch (c) {
		case uniqe(): return "unique";
		case key(): return "primary key";
		case notNull(): return "not null";
		case references(tbl, col): return "foreign key references <tbl>(<col>)";
		default: throw "Unhandled constraint: <c>";
	}
}