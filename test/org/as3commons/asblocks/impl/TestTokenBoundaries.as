package org.as3commons.asblocks.impl
{

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertTrue;
import org.as3commons.asblocks.parser.api.IParserNode;
import org.as3commons.asblocks.parser.core.SourceCode;
import org.as3commons.asblocks.parser.impl.AS3FragmentParser;
import org.as3commons.asblocks.ASFactory;
import org.as3commons.asblocks.CodeMirror;
import org.as3commons.asblocks.api.BinaryOperator;
import org.as3commons.asblocks.api.IBinaryExpression;
import org.as3commons.asblocks.api.IExpression;
import org.as3commons.asblocks.api.IFieldAccessExpression;
import org.as3commons.asblocks.api.IPostfixExpression;
import org.as3commons.asblocks.api.IPrefixExpression;
import org.as3commons.asblocks.api.PostfixOperator;
import org.as3commons.asblocks.api.PrefixOperator;

public class TestTokenBoundaries
{
	private var factory:ASFactory = new ASFactory();
	
	private var expression:IBinaryExpression;	
	
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
	public function testAdd():void
	{
		var expr:IExpression = factory.newExpression("1+1");
		assertTrue(expr is IBinaryExpression);
		var add:IBinaryExpression = expr as IBinaryExpression;
		assertEquals(BinaryOperator.ADD, add.operator);
	}
	
	[Test]
	public function testMultiplyAddPresidence():void
	{
		// addition has lower presidence, so appears higher in AST
		var expr:IExpression = factory.newExpression("1+2*2");
		assertTrue(expr is IBinaryExpression);
		var add:IBinaryExpression = expr as IBinaryExpression;
		assertEquals(BinaryOperator.ADD, add.operator);
		var right:IBinaryExpression = add.rightExpression as IBinaryExpression;
		assertEquals(BinaryOperator.MUL, right.operator);
		
		// addition still has lower presidence, so appears higher in AST
		expr = factory.newExpression("2*2+1");
		assertTrue(expr is IBinaryExpression);
		add = expr as IBinaryExpression;
		assertEquals(BinaryOperator.ADD, add.operator);
		var left:IBinaryExpression = add.leftExpression as IBinaryExpression;
		assertEquals(BinaryOperator.MUL, left.operator);
	}
	
	
	[Test]
	public function testPreIncrement():void
	{
		var expr:IExpression = factory.newExpression("++i");
		assertTrue(expr is IPrefixExpression);
		var inc:IPrefixExpression = IPrefixExpression(expr);
		assertEquals(PrefixOperator.PREINC, inc.operator);
	}
	
	[Test]
	public function testPostIncrement():void
	{
		var expr:IExpression = factory.newExpression("i++");
		assertTrue(expr is IPostfixExpression);
		var inc:IPostfixExpression = IPostfixExpression(expr);
		assertEquals(PostfixOperator.POSTINC, inc.operator);
	}
	
	
	[Test]
	public function testInvokeInvocation():void
	{
		var expr:IExpression = factory.newExpression("a().b()");
		IFieldAccessExpression(expr).name;
		var buff:SourceCode = new SourceCode();
		var ast:IParserNode = expr.node;
		//CodeMirror.assertTokenStreamNotDisjoint(ast);
		new ASTPrinter(buff).print(ast);
		var parsed:IParserNode = AS3FragmentParser.parseExpression(buff.code);
		CodeMirror.assertASTMatch(ast, parsed);
	}
	
	[Test]
	public function testLogicalOr():void
	{
		expression = factory.newExpression("a || b || c") as IBinaryExpression;
		var left:IExpression = factory.newExpression("foo");
		expression.leftExpression = left;
		
	}
}
}