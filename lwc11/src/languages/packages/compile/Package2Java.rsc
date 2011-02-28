module languages::packages::compile::Package2Java

import languages::packages::ast::Packages;
import languages::entities::ast::Entities;
import languages::entities::compile::Entities2Java;

import List;	

public str package2java(Package pkg) {
	return "
package <pkg.name>;

<for (i <- pkg.imports) {>
import <i.name>.*;
<}>

<intercalate("\n", entities2java(pkg.entities))>	
";
}


// TODO: need extend! Entities2Java does not see this.
public str type2java(qualified(str pkg, str name)) = "<pkg>.<name>";