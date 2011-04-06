module lang::entities::transform::Entities2Database

import lang::entities::ast::Entities;
import lang::database::ast::Database;

private str KEY = "_id";

public Database entities2database(Entities es) {
	tables = [ entity2table(e) | e <- es.entities ];
	return database(tables);
}

public Table entity2table(Entity e) {
	cols = [column(KEY, integer(), [key()])] + [ field2column(f) | f <- e.fields ];
	return table(e.name.name, cols); 
}

public Column field2column(Field f) {
	t = type2columnType(f.\type);
	cs = [];
	if (reference(name(e)) := f.\type) {
		cs = [references(e, KEY)];
	}
	return column(f.name, t, cs);
}

public ColumnType type2columnType(Type t) {
	switch (t) {
		case primitive(PrimitiveType::string()): 	return ColumnType::varchar(); 
     	case primitive(PrimitiveType::date()): 		return ColumnType::date();
     	case primitive(PrimitiveType::integer()): 	return ColumnType::integer();
     	case primitive(PrimitiveType::boolean()): 	return ColumnType::boolean();
     	case reference(_): 							return ColumnType::integer();
     	default: throw "Unhandled type: <t>";	
	}
}