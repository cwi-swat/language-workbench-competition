module lang::instances::check::Instances

import lang::entities::ast::Entities;
import lang::entities::check::Entities; // for nameStr
import lang::entities::utils::Merge;
import lang::entities::utils::Load;
import lang::instances::ast::Instances;

import Node;
import Map;
import IO;
import Message;

public list[Message] check(loc path, Instances is) {
	return check(is, merge({ load(path, r.name) | r <- is.requires }));
}

public list[Message] check(Instances is, Entities es) {
	edefs = ( e.name: e | e <- es.entities );
	idefs = ();
	errors = for (i <- is.instances) {
		if (i.\type notin edefs) {
		  	append error("Undefined type", i@location);
		}
		if (i.name in idefs) {
			append error("Duplicate instance", i@location);
		}
		idefs[i.name] = i.\type;
	}
	return ( errors | it + checkInstance(i, idefs, edefs[idefs[i.name]]) 
					| i <- is.instances, i.\type in edefs );
}

public list[Message] checkInstance(Instance i, map[Name, Name] idefs, Entity e) {
	fdefs = ( f.name: f.\type | f <- e.fields );
	
	list[Message] errors = [ error("Undefined field", a@location) 
					| a <- i.assigns, a.name notin fdefs ];
	
	errors += [ error("Undefined instance", a@location)
					| a <- i.assigns,  Value::reference(Name n) := a.exp, n notin idefs ];
				
	errors += [ error("Missing field <n>", i@location) 
					| n <- domain(fdefs) - { a.name | a <- i.assigns } ];
	
	return ( errors | it + checkTypes(a, fdefs[a.name], a.exp, idefs) 
					| a <- i.assigns, a.name in fdefs );
}


public list[Message] checkTypes(Assign a, Type t, Expression v, map[Name, Name] idefs) {
	list[Message] typeError() {
		return [error("Expected type <getName(t.primitive)> for <a.name> but got <getName(v)>", v@location)];
	}	

   	switch (<t, v>) {
    	case <primitive(string()), !const(Value::string(_))>:   return typeError();
     	case <primitive(date()), !const(Value::date(_, _, _))>: return typeError();
     	case <primitive(integer()), !const(Value::integer(_))>: return typeError();
     	case <primitive(currency()), !const(Value::float(_))>:  return typeError();
     	case <primitive(boolean()), !const(Value::boolean(_))>: return typeError();
     	
     	case <reference(Name req), !reference(_)>:
     			return [error("Expected a reference to <req> for <a.name> but got <getName(v)>", v@location)];
     	
     	case <reference(Name req), _>:  
     		if (actual := idefs[v.name], actual != req) {
     	    	return [error("Field should have type <nameStr(req)> but is <nameStr(actual)>", v@location) ];
     		}
     	  
   }
   return [];
}