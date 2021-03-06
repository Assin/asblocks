package org.as3commons.asblocks.impl
{

import org.flexunit.asserts.assertEquals;
import org.as3commons.asblocks.parser.api.IParserNode;
import org.as3commons.asblocks.parser.core.SourceCode;
import org.as3commons.asblocks.parser.impl.AS3FragmentParser;
import org.as3commons.asblocks.ASFactory;
import org.as3commons.asblocks.CodeMirror;
import org.as3commons.asblocks.api.IArrayLiteral;
import org.as3commons.asblocks.api.INumberLiteral;

public class TestArrayLiteralNode
{
	private var factory:ASFactory = new ASFactory();
	
	private var expression:IArrayLiteral;
	
	[Before]
	public function setUp():void
	{
		expression = null;
	}
	
	[After]
	public function tearDown():void
	{
		if (expression)
		{
			var sourceCode:SourceCode = new SourceCode();
			var ast:IParserNode = expression.node;
			new ASTPrinter(sourceCode).print(ast);
			var parsed:IParserNode = AS3FragmentParser.parseExpression(sourceCode.code);
			CodeMirror.assertASTMatch(ast, parsed);
		}
	}
	
	[Test]
	public function testBasic():void
	{
		expression = factory.newArrayLiteral();
		expression.add(factory.newExpression("1"));
		expression.add(factory.newExpression("a"));
		expression.add(factory.newExpression("3"));
		assertEquals(expression.entries.length, 3);
	}
	
	[Test]
	public function testParse():void
	{
		expression = factory.newExpression("[1, \"a\", 3]") as IArrayLiteral;
	}
	
	[Test]
	public function test_add_remove():void
	{
		expression = factory.newArrayLiteral();
		expression.add(factory.newExpression("1"));
		expression.add(factory.newExpression("2"));
		expression.add(factory.newExpression("3"));
		assertEquals(expression.entries.length, 3);
		expression.remove(0);
		assertEquals(expression.entries.length, 2);
		assertEquals(INumberLiteral(expression.entries[0]).value, 2);
		assertEquals(INumberLiteral(expression.entries[1]).value, 3);
	}
}
}