module Plugin

import lang::entities::ide::Entities;
import lang::instances::ide::Instances;
import lang::packages::ide::Packages;

public void main() {
	registerEntities();
	registerInstances();
	registerPackages();
}