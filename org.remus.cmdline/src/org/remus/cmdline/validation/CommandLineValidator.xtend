/*
 * generated by Xtext
 */
package org.remus.cmdline.validation

import org.eclipse.xtext.validation.Check
import org.remus.cmdline.commandLine.CommandLinePackage
import org.remus.cmdline.commandLine.Function
import org.remus.cmdline.commandLine.Program
import org.remus.cmdline.commandLine.Param
import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.emf.common.util.URI

//import org.eclipse.xtext.validation.Check
/**
 * Custom validation rules. 
 *
 * see http://www.eclipse.org/Xtext/documentation.html#validation
 */
class CommandLineValidator extends AbstractCommandLineValidator { //  public static val INVALID_NAME = 'invalidName'
	//
	@Check
	def checkValidProgramName(Program program) {
		if (!program.name.matches("^[a-zA-Z0-9_-]+")) {
			error("Name of programs can have only letters, numbers,'-' or '_'.",
				CommandLinePackage.Literals.PROGRAM__NAME);
		}
	}
	@Check
	def checkSystemOnce(org.remus.cmdline.commandLine.System system) {
		
	}

	@Check
	def checkValidFunctionName(Function function) {
		if (!function.name.matches("^[a-zA-Z0-9_-]+")) {
			error("Name of functions can have only letters, numbers,'-' or '_'.",
				CommandLinePackage.Literals.FUNCTION__NAME);
		}
	}

	@Check
	def checkValidParmaneterName(Param param) {
		if (!param.name.matches("^[a-zA-Z0-9_-]+")) {
			error("Name of parameters can have only letters, numbers,'-' or '_'.",
				CommandLinePackage.Literals.PARAM__NAME);
		}
	}
}
