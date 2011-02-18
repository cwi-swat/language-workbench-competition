module languages::entities::transform::Entities2Beans

import languages::beans::ast::Beans;
import languages::entities::ast::Entities;

private str KEY = "_id";

public list[Bean] entities2beans(Entities es) {
	return  [ entity2bean(e) | e <- es.entities ];
}

public Bean entity2bean(Entity e) {
	return bean(e.name.name,
		[ attribute(f.name, beanType(f.\type)) | f <- e.fields ],
		[ getter(n, bt), setter(n, bt) | field(t, n) <- e.fields, bt := beanType(t) ]
	);
}

public str beanType(Type t) {
	switch (t) {
		case primitive(PrimitiveType::string()): 	return "java.lang.String"; 
     	case primitive(PrimitiveType::date()): 		return "java.util.Date";
     	case primitive(PrimitiveType::integer()): 	return "java.lang.Integer";
     	case primitive(PrimitiveType::boolean()): 	return "java.lang.Boolean";
     	case reference(Name n): 					return n.name;
     	default: throw "Unhandled type: <t>";	
	}
}