module languages::instances::check::Instances

import languages::entities::ast::Entities;
import languages::instances::ast::Instances;

import Node;
import Map;
import IO;

public list[str] check(Instances is, Entities es) {
	edefs = ( e.name: e | e <- es.entities );
	idefs = ();
	errors = for (i <- is.instances) {
		if (i.\type notin edefs) {
		  	append "Declared type of <i.name> (<i.\type>) is undefined.";
		}
		if (i.name in idefs) {
			append "Duplicate instance <i.name>.";
		}
		idefs[i.name] = i.\type;
	}
	return ( errors | it + checkInstance(i, idefs, edefs[idefs[i.name]]) 
					| i <- is.instances, i.\type in edefs );
}

public list[str] checkInstance(Instance i, map[str, str] idefs, Entity e) {
	fdefs = ( f.name: f.\type | f <- e.fields );
	
	list[str] errors = [ "Field <a.name> in <i.name> is undefined in <e.name>" 
					| a <- i.assigns, a.name notin fdefs ];
	
	errors += [ "Field <a.name> in <i.name> references undefined instance <n>"
					| a <- i.assigns,  Value::reference(str n) := a.\value, n notin idefs ];
				
	println(errors);
	errors += [ "Required field <e.name>.<n> is missing in <i.name>" 
					| n <- domain(fdefs) - { a.name | a <- i.assigns } ];
	
	return ( errors | it + checkTypes("<i.name>.<a.name>", fdefs[a.name], a.\value, idefs) 
					| a <- i.assigns, a.name in fdefs );
}


public list[str] checkTypes(str f, Type t, Value v, map[str, str] idefs) {
	list[str] typeError() {
		return ["Expected type <getName(t.primitive)> for <f> but got <getName(v)>"];
	}	

   	switch (<t, v>) {
    	case <primitive(string()), !string(_)>:   return typeError();
     	case <primitive(date()), !date(_, _, _)>: return typeError();
     	case <primitive(integer()), !integer(_)>: return typeError();
     	case <primitive(boolean()), !boolean(_)>: return typeError();
     	
     	case <reference(str req), !reference(_)>:
     			return ["Expected a reference to <req> for <f> but got <getName(v)>"];
     	
     	case <reference(str req), _>:  
     		if (actual := idefs[v.name], actual != req) {
     	    	return ["Instance <v.name> referenced by field <f> should have type <req> but is <actual>"];
     		}
     	  
    	default: throw "Unhandled type: <t>";
   }
   return [];
}