module languages::entities::transform::Entities2Database

import languages::entities::ast::Entities;
import languages::database::ast::Database;

private str KEY = "_id";

public Database entities2database(Entities es) {
	tables = [ entity2table(e) | e <- es.entities ];
	return database(tables);
}

public Table entity2table(Entity e) {
	cols = [column(KEY, integer(), [key()])] + [ field2column(f) | f <- e.fields ];
	return table(e.name, cols); 
}

public Column field2column(Field f) {
	t = type2columnType(f.\type);
	cs = [];
	if (reference(e) := f.\type) {
		cs = [references(e, KEY)];
	}
	return column(f.name, t, cs);
}

public ColumnType type2columnType(Type t) {
	switch (t) {
		case primitive(PrimitiveType::string()): 	return ColumnType::varchar(); 
     	case primitive(PrimitiveType::date()): 		return ColumnType::date();
     	case primitive(PrimitiveType::integer()): 	return ColumnType::Type::integer();
     	case primitive(PrimitiveType::boolean()): 	return ColumnType::Type::boolean();
     	case reference(str req): 					return ColumnType::integer();
     	default: throw "Unhandled type: <t>";	
	}
}