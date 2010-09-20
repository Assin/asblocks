package org.teotigraphix.asblocks.impl
{

import org.flexunit.asserts.assertNotNull;
import org.teotigraphix.as3parser.api.IParserNode;
import org.teotigraphix.as3parser.core.SourceCode;
import org.teotigraphix.as3parser.impl.AS3FragmentParser;
import org.teotigraphix.asblocks.ASFactory;
import org.teotigraphix.asblocks.CodeMirror;
import org.teotigraphix.asblocks.api.IBlock;
import org.teotigraphix.asblocks.api.IBreakStatement;

public class TestBreakStatement
{
	private var factory:ASFactory = new ASFactory();
	
	private var block:IBlock;
	
	private var expression:IBreakStatement;
	
	[Before]
	public function setUp():void
	{
		block = null;
		expression = null;
	}
	
	[After]
	public function tearDown():void
	{
		if (expression)
		{
			var sourceCode:SourceCode = new SourceCode();
			var ast:IParserNode = block.node;
			new ASTPrinter(sourceCode).print(ast);
			var parsed:IParserNode = AS3FragmentParser.parseStatement(sourceCode.code);
			CodeMirror.assertASTMatch(ast, parsed);
		}
	}
	
	[Test]
	public function testBasic():void
	{
		block = factory.newBlock();
		expression = block.newBreak();
	}
	
	[Test]
	public function testBasicLabel():void
	{
		block = factory.newBlock();
		expression = block.newBreak("foo");
	}
	
	[Test]
	public function testParse():void
	{
		block = factory.newBlock();
		expression = block.addStatement("break") as IBreakStatement;
		assertNotNull(expression);
	}
	
	[Test]
	public function testParseLabel():void
	{
		block = factory.newBlock();
		expression = block.addStatement("break foo") as IBreakStatement;
		assertNotNull(expression);
	}
	
	// FIXME implement IBreakStatement.label set correctly
	//[Test]
	public function test_label():void
	{
		block = factory.newBlock();
		expression = block.addStatement("break foo") as IBreakStatement;
		//assertNotNull(expression.label);
		//assertEquals("foo", ISimpleNameExpression(expression.label).name);
		//expression.label = null;
		//assertNull(expression.label);
		//expression.label = factory.newExpression("bar");
		//assertEquals("bar", ISimpleNameExpression(expression.label).name);
	}
	
	//[Test]
	public function test_set_label():void
	{
		block = factory.newBlock();
		expression = block.addStatement("break") as IBreakStatement;
		expression.label = factory.newExpression("bar");
	}
}
}