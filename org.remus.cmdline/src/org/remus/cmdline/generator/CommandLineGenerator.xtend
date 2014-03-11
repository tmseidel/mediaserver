/*
 * generated by Xtext
 */
package org.remus.cmdline.generator

import java.io.StringWriter
import javax.inject.Inject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.JavaIoFileSystemAccess
import org.remus.cmdline.commandLine.Concatenation
import org.remus.cmdline.commandLine.DataDefinition
import org.remus.cmdline.commandLine.Expression
import org.remus.cmdline.commandLine.Function
import org.remus.cmdline.commandLine.IntegerLiteral
import org.remus.cmdline.commandLine.Program
import org.remus.cmdline.commandLine.StringLiteral
import org.remus.cmdline.commandLine.DataType
import java.util.ArrayList

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class CommandLineGenerator implements IGenerator {
	
	
	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		
		for (e : resource.allContents.toIterable.filter(Function)) {
			fsa.generateFile("commands/" + javaName(e)+".java",compile(e));
			fsa.generateFile("controller/" + javaName(e)+"Controller.java",controller(e));
			fsa.generateFile("views/" + javaName(e)+".jsp",jsp(e));
		}

	}

def controller(Function function) {
		'''
package com.remus.mediaserver.controller.generated;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.remus.mediaexeutor.exec.«javaName(function)»;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.remus.mediaserver.service.ExecutionService;

/**
 * 
 * WARNING: This class is generated code. Please do not modify its content.
 * 
 * @author Tom Seidel - tom.seidel@remus-software.org
 * 
 * 
 */
@Controller
public class «javaName(function)»Controller {

	@Inject
	private ExecutionService executionService;

	@PostConstruct
	public void register() {
		executionService.register(«javaName(function)».getMeta());
	}

	@RequestMapping(value = "/«function.javaName.toString.toLowerCase»", method = RequestMethod.GET)
	public String «function.name.toLowerCase»(final Model model) {
		return "generated/«javaName(function)»";
	}

	@RequestMapping(value = "/«function.javaName.toString.toLowerCase»_run", method = RequestMethod.POST)
	public String «function.name.toLowerCase»Run(final MultipartHttpServletRequest request4011,
			final Model model4011) {
		«FOR m:function.input»
		final String «m.input.name» = executionService.process«m.type.literal.toLowerCase.toFirstUpper»Input(
				request4011, "«m.input.name»");
		
		«ENDFOR»
		«FOR m:function.output»
		final String «m.input.name» = executionService.process«m.type.literal.toLowerCase.toFirstUpper»Output(
				request4011, "«m.input.name»");
		
		«ENDFOR»
		final «javaName(function)» «javaName(function).toString.toLowerCase» = «javaName(function)»
				.create(«argumentsList(function,false)»);
		final String run4011 = executionService.run(«javaName(function).toString.toLowerCase»);
		model4011.addAttribute("jobId", run4011);
		return "home";

	}

	@RequestMapping(value = "/«function.javaName.toString.toLowerCase»_runservice", method = RequestMethod.POST)
	public @ResponseBody
	String rotateRunService(final MultipartHttpServletRequest request4011) {
		«FOR m:function.input»
		final String «m.input.name» = executionService.process«m.type.literal.toLowerCase.toFirstUpper»Input(
				request4011, "«m.input.name»");
		
		«ENDFOR»
		«FOR m:function.output»
		final String «m.input.name» = executionService.process«m.type.literal.toLowerCase.toFirstUpper»Output(
				request4011, "«m.input.name»");
		
		«ENDFOR»
		final «javaName(function)» «javaName(function).toString.toLowerCase» = «javaName(function)»
				.create(«argumentsList(function,false)»);
		final String run4011 = executionService.run(«javaName(function).toString.toLowerCase»);
		return run4011;

	}

}

		'''
	}

def jsp(Function function) {
	
		'''
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE HTML>
<!--
	Minimaxing 3.1 by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		
		<title>Remus Exec</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link href="http://fonts.googleapis.com/css?family=Ubuntu+Condensed" rel="stylesheet">
		<script src="<c:url value="resources/js/jquery.min.js" />"></script>
		<script src="<c:url value="resources/js/config.js" />"></script>
		<script src="<c:url value="resources/js/skel.min.js" />"></script>
		<script src="<c:url value="resources/js/skel-panels.min.js" />"></script>
		<noscript>
			<link rel="stylesheet" href="<c:url value="resources/css/skel-noscript.css" />" />
			<link rel="stylesheet" href="<c:url value="resources/css/style.css" />" />
			<link rel="stylesheet" href="<c:url value="resources/css/style-desktop.css" />" />
		</noscript>
		
		<!--[if lte IE 9]><link rel="stylesheet" href="css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><script src="js/html5shiv.js"></script><![endif]-->
	</head>
	<body>
	<!-- ********************************************************* -->
		<div id="header-wrapper">
			<div class="container">
				<div class="row">
					<div class="12u">
						
						<header id="header">
							<h1><a href="#" id="logo">«function.javaName»</a></h1>
							<nav id="nav">
								<a href="<c:url value="/" />">Homepage</a>
								<a href="<c:url value="programs.htm" />" class="current-page-item">Programs</a>
								<a href="<c:url value="resources/static/rest.html" />">REST Services</a>
								<a href="<c:url value="resources/static/about.html" />">About</a>
							</nav>
						</header>
						
					</div>
				</div>
			</div>
		</div>
		<div id="banner-wrapper">
			<div class="container">
				<div class="row">
					<div class="12u" style="height:20px;">
					
						
					</div>
				</div>
			</div>
		</div>
		<div id="main">
			<div class="container">
				<div class="row main-row">
					<div class="8u">
						<form action="<c:url value="«function.javaName.toString.toLowerCase»_run" />" method="post" enctype="multipart/form-data" name="scheduleForm">
						<section>
							<h2>«function.javaName»</h2>
							<div>
								«FOR m:function.input»
									<div>
										  <label for="«m.input.name»">«IF m.doc != null»«m.doc.value»«ELSE»«m.input.name»«ENDIF»</label>&nbsp;<input class='fileInput' type="«IF m.type == DataType.PATH»file«ELSEIF  m.type == DataType.STRING || m.type == DataType.URL»text«ENDIF»" name="«m.input.name»"  />
	   								</div>
								«ENDFOR»
								«FOR m:function.output.filter[type == DataType.PATH]»
									<div>
										  <label for="«m.input.name»">«IF m.doc != null»«m.doc.value»«ELSE»«m.input.name»«ENDIF»</label>&nbsp;<input class='fileInput' type="text" name="«m.input.name»"  />
	   								</div>
								«ENDFOR»
							</div>
							<a href="#" class="button" onClick="document.scheduleForm.submit();">Submit</a>
						</section>
					</form>
					
					</div>
					<div class="4u">
						
						<section class="right-content">
							<h2>Documentation</h2>
							<p>«function.desc.escape»</p>
							«IF function.docurl != null»
							<p><a href="«function.docurl.value»" target="_blank">Furhter information</a></p>
							«ENDIF»
						</section>
					</div>
				</div>
			</div>
		</div>
		<div id="footer-wrapper">
			<div class="container">
				<div class="row">
					<div class="12u">

						<div id="copyright">
							&copy; Tom Seidel - Remus Software. All rights reserved. | Design: <a href="http://html5up.net">HTML5 UP</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	<!-- ********************************************************* -->
	</body>
</html>
		'''
	}

	
	def compile(Function function) {
		
		
		'''
package org.remus.mediaexeutor.exec;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.PumpStreamHandler;
import org.apache.log4j.Logger;
import org.remus.mediaexeutor.base.Arguments;
import org.remus.mediaexeutor.base.ExecutionInstruction;
import org.remus.mediaexeutor.data.Meta;
import org.remus.mediaexeutor.data.ParamDataType;
import org.remus.mediaexeutor.data.ParamType;
import org.remus.mediaexeutor.data.ResultDataElement;


/**
 * 
 * WARNING: This class is generated code. Please do not modify its content.
 * 
 * @author Tom Seidel - tom.seidel@remus-software.org
 * 
 * 
 */
public class «javaName(function)» extends ExecutionInstruction {
	private final Logger LOGGER = Logger.getLogger(«javaName(function)».class);
	
	private static Meta meta; 
	
	static {
		meta = new Meta();
		meta.setId("«function.javaName.toString.toLowerCase»");
		meta.setProgram("«(function.eContainer as Program).name»");
		meta.setFunction("«function.name»");
		meta.setDoc("«function.desc.escape»");
		meta.setDocUrl("«function.docurl.escape»");
		«FOR m:function.input»
		meta.addInputParameter("«m.input.name»","«m.doc.escape»");
		«ENDFOR»
		«FOR m:function.output»
		meta.addInputParameter("«m.input.name»","«m.doc.escape»");
		«ENDFOR»
	}
		
	
	public «javaName(function)»(final Arguments createArguments) {
		super(createArguments);
	}
	
	public static Meta getMeta() {
		return meta;
	}
	
	public static «javaName(function)» create(«argumentsList(function,true)») {
		return new «javaName(function)»(createArguments(«argumentsList(function,false)»));
	}
	private static Arguments createArguments(«argumentsList(function,true)») {
		final Arguments arguments = new Arguments();
		return arguments
		«FOR m: function.input»
		.add("«m.input.name»", «m.input.name»)
		«ENDFOR»
		«FOR m: function.output»
		.add("«m.input.name»", «m.input.name»)
		«ENDFOR»
				;
	}
	public boolean checkArguments() {
		boolean valid = true;
		«FOR m: function.input»
		«inputCheck(m)»
		«ENDFOR»
		«FOR m: function.output»
		«outputCheck(m)»
		«ENDFOR»
		return true;
	}
	
	@Override
	protected int internalExecute() throws IOException {
		LOGGER.info("Starting execution with arguments: " + arguments);
		«FOR m : function.input»
		final String «m.input.name» = arguments.get("«m.input.name»");
		«ENDFOR»
		«FOR m : function.output»
		final String «m.input.name» = arguments.get("«m.input.name»");
		«ENDFOR»
		final CommandLine cmd = new CommandLine("«(function.eContainer as Program).name»");
		«FOR m:function.optionBlocks»
		cmd.addArgument(«expression2String(m.param,false)»);
		«ENDFOR»
		final DefaultExecutor executor = new DefaultExecutor();
		LOGGER.info("About to execute: " + cmd);
		executor.setStreamHandler(new PumpStreamHandler(getProcessStream(),
				getErrorStream()));
		int execute;
		try {
			execute = executor.execute(cmd);
			LOGGER.info(MessageFormat.format(
					"Execution finished with Code {0}", execute));
		} catch (final IOException e) {
			LOGGER.error(e);
			throw e;
		}
		return execute;

	}
	
	
	@Override
	public List<ResultDataElement> getOutputElements() {
		final List<ResultDataElement> returnValue = new ArrayList<ResultDataElement>();
		«FOR m:function.output»
		returnValue.add(new ResultDataElement("«m.input.name»",arguments.get("«m.input.name»"),
				ParamDataType.«m.type.literal», "«IF m.doc != null»«m.doc.value.replace("\n", "").replace("\r", "").escape»«ENDIF»"));
		«ENDFOR»
		return returnValue;
	}
	
	@Override
	public List<ResultDataElement> getInputElements() {
		final List<ResultDataElement> returnValue = new ArrayList<ResultDataElement>();
		«FOR m:function.input»
		returnValue.add(new ResultDataElement("«m.input.name»",arguments.get("«m.input.name»"),
				ParamDataType.«m.type.literal», "«IF m.doc != null»«m.doc.value.replace("\n", "").replace("\r", "").escape»«ENDIF»"));
		«ENDFOR»
		return returnValue;
	}
	
}
		'''
	}

def inputCheck(DataDefinition definition) {
		'''
		
		valid &= checkArgument(arguments.get("«definition.input.name»"), ParamDataType.«definition.type.literal»,
				ParamType.INPUT);
		if (!valid) {
			return false;
		}
		'''
	}
def outputCheck(DataDefinition definition) {
		'''
		valid &= checkArgument(arguments.get("«definition.input.name»"), ParamDataType.«definition.type.literal»,
				ParamType.OUTPUT);
		if (!valid) {
			return false;
		}
		'''
	}

def argumentsList(Function function, boolean datatype) {
	val list = new ArrayList(function.input)
	list.addAll(function.output) 
	'''
		«FOR param : list SEPARATOR ','»
			«IF datatype»final String «ENDIF»«(param as DataDefinition).input.name»
		«ENDFOR»
	'''
	}
	
	def javaName(Function function) {
		val program = function.eContainer as Program
		'''«program.name.toFirstUpper»_«function.name.toFirstUpper»'''
	}
	
	def expression2String (Expression expression, boolean escapeParams) {
		val returnValue = new StringWriter();
		if( expression instanceof Concatenation ) {
			val concat = (expression as Concatenation)
			returnValue.append(expression2String(concat.left,escapeParams) + "+" +expression2String(concat.right,escapeParams));
		} else if( expression instanceof StringLiteral) {
			val string = (expression as StringLiteral)
			returnValue.append("\"" + string.escape +"\"")
		} else if( expression instanceof IntegerLiteral) {
			val inte = (expression as IntegerLiteral)
			returnValue.append(inte.value+"")
		} else {
			if (escapeParams) {
				returnValue.append("arguments.get("+expression.param.name+")");	
			} else {
				returnValue.append(expression.param.name);	
			}
		}
		return returnValue.toString
	}
	
	
	def escape(String string) {
		'''«string.replace("\'","\\\'").replace("\"","\\\"")»'''
		
	}
	def escape(StringLiteral string) {
		'''«IF string!= null && string.value != null»«string.value.escape»«ENDIF»'''
		
	}

}
