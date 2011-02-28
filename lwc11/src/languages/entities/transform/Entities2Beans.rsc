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

public str beanType(primitive(string())) = 		"java.lang.String";
public str beanType(primitive(date())) = 		"java.util.Date";
public str beanType(primitive(integer())) = 	"java.lang.Integer";
public str beanType(primitive(boolean())) = 	"java.lang.Boolean";
public str beanType(reference(name(str n))) = 	n;

