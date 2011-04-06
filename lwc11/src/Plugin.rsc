module Plugin

import lang::entities::ide::Entities;
import lang::instances::ide::Instances;
import lang::packages::ide::Packages;
import lang::derived::ide::Derived;

public void main() {
	registerEntities();
	registerInstances();
	registerPackages();
	registerDerived();
}