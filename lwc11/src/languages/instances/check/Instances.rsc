module languages::instances::check::Instances

import languages::entities::ast::Entities;
import languages::instances::ast::Instances;

import Node;
import Map;
import IO;
import Message;

public list[Message] check(Instances is, Entities es) {
	edefs = ( e.name: e | e <- es.entities );
	idefs = ();
	errors = for (i <- is.instances) {
		if (i.\type notin edefs) {
		  	append error("Declared type of <i.name> (<i.\type>) is undefined.", i@location);
		}
		if (i.name in idefs) {
			append error("Duplicate instance <i.name>.", i@location);
		}
		idefs[i.name] = i.\type;
	}
	return ( errors | it + checkInstance(i, idefs, edefs[idefs[i.name]]) 
					| i <- is.instances, i.\type in edefs );
}

public list[Message] checkInstance(Instance i, map[Name, Name] idefs, Entity e) {
	fdefs = ( f.name: f.\type | f <- e.fields );
	
	list[Message] errors = [ error("Field <a.name> in <i.name> is undefined in <e.name>", a@location) 
					| a <- i.assigns, a.name notin fdefs ];
	
	errors += [ error("Field <a.name> in <i.name> references undefined instance <n>", a@location)
					| a <- i.assigns,  Value::reference(str n) := a.\value, n notin idefs ];
				
	errors += [ error("Required field <e.name>.<n> is missing in <i.name>", i@location) 
					| n <- domain(fdefs) - { a.name | a <- i.assigns } ];
	
	return ( errors | it + checkTypes(a, fdefs[a.name], a.\value, idefs) 
					| a <- i.assigns, a.name in fdefs );
}


public list[Message] checkTypes(Assign a, Type t, Value v, map[Name, Name] idefs) {
	list[Message] typeError() {
		return [error("Expected type <getName(t.primitive)> for <a.name> but got <getName(v)>", v@location)];
	}	

   	switch (<t, v>) {
    	case <primitive(string()), !Value::string(_)>:   return typeError();
     	case <primitive(date()), !Value::date(_, _, _)>: return typeError();
     	case <primitive(integer()), !Value::integer(_)>: return typeError();
     	case <primitive(boolean()), !Value::boolean(_)>: return typeError();
     	
     	case <reference(Name req), !reference(_)>:
     			return [error("Expected a reference to <req> for <a.name> but got <getName(v)>", v@location)];
     	
     	case <reference(Name req), _>:  
     		if (actual := idefs[v.name], actual != req) {
     	    	return [error("Instance <v.name> referenced by field <a.name> should have type <req> but is <actual>", v@location) ];
     		}
     	  
   }
   return [];
}