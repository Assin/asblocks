package org.teotigraphix.asblocks.impl
{

import org.teotigraphix.asblocks.api.IExpressionNode;
import org.teotigraphix.as3parser.api.AS3NodeKind;
import org.teotigraphix.as3parser.api.IParserNode;

public class ExpressionBuilder
{
	public static function build(ast:IParserNode):IExpressionNode
	{
		switch (ast.kind)
		{
			case AS3NodeKind.NUMBER:
				return new NumberLiteralNode(ast);
			
			case AS3NodeKind.STRING:
				return new StringLiteralNode(ast);
				
			case AS3NodeKind.NULL:
				return new NullLiteralNode(ast);
			
			case AS3NodeKind.TRUE:
			case AS3NodeKind.FALSE:
				return new BooleanLiteralNode(ast);
				
			case AS3NodeKind.CALL:
				return new InvocationExpressionNode(ast);
				
			case AS3NodeKind.ARRAY:
				return new ArrayLiteralNode(ast);
				
			case AS3NodeKind.OBJECT:
				return new ObjectLiteralNode(ast);
				
			case AS3NodeKind.ASSIGN:
				return new AssignmentExpressionNode(ast);
				
			case AS3NodeKind.PRIMARY:
				return new SimpleNameExpressionNode(ast);
			
			case AS3NodeKind.ARRAY_ACCESSOR:
				return new ArrayAccessExpressionNode(ast);
				
			default:
				throw new Error("unhandled expression node type: " + ast.kind);
			
			/*
			
				NUMBER
				- IntegerLiteralNode
				STRING
				- StringLiteralNode
				NULL
				- NullLiteralNode
				TRUE
				FALSE
				- BooleanLiteralNode
				ASSIGN
				- AssignmentExpressionNode
				OP
				- BinaryExpressionNode
				POST_DEC
				POST_INC
				- PostfixExpressionNode
				PRE_DEC
				PRE_INC
				PLUS
				MINUS
				NOT
				- PrefixExpressionNode
				DOT
				- FieldAccessExpressionNode
				CALL
				- InvocationExpressionNode
				ENCAPSULATED
				- return build(ast.getFirstChild());
				ARRAY_ACCESSOR
				- ArrayAccessExpressionNode
				NEW
				- NewExpressionNode
				CONDITIONAL
				- ConditionalExpressionNode
				UNDEFINED
				- UndefinedLiteralNode
				FUNCTION
				- FunctionExpressionNode
				ARRAY
				- ArrayLiteralNode
				OBJECT
				- ObjectExpressionNode
				XML
				- XMLExpressionNode
				
			*/
				
			/*
			`case AS3Parser.DECIMAL_LITERAL:
				return new ASTASIntegerLiteral(ast);
			`case AS3Parser.STRING_LITERAL:
				return new ASTASStringLiteral(ast);
			`case AS3Parser.NULL:
				return new ASTASNullLiteral(ast);
			`case AS3Parser.TRUE:
			`case AS3Parser.FALSE:
				return new ASTASBooleanLiteral(ast);
			`case AS3Parser.PLUS_ASSIGN:
			`case AS3Parser.ASSIGN:
			case AS3Parser.BAND_ASSIGN:
			case AS3Parser.BOR_ASSIGN:
			case AS3Parser.BXOR_ASSIGN:
			case AS3Parser.DIV_ASSIGN:
			case AS3Parser.MOD_ASSIGN:
			case AS3Parser.STAR_ASSIGN:
			case AS3Parser.SL_ASSIGN:
			case AS3Parser.SR_ASSIGN:
			case AS3Parser.BSR_ASSIGN:
			case AS3Parser.MINUS_ASSIGN:
				return new ASTASAssignmentExpression(ast);
			case AS3Parser.PLUS:
			case AS3Parser.LAND:
			case AS3Parser.BAND:
			case AS3Parser.BOR:
			case AS3Parser.BXOR:
			case AS3Parser.DIV:
			case AS3Parser.EQUAL:
			case AS3Parser.GE:
			case AS3Parser.GT:
			case AS3Parser.LE:
			case AS3Parser.LT:
			case AS3Parser.MOD:
			case AS3Parser.MULT:
			case AS3Parser.NOT_EQUAL:
			case AS3Parser.LOR:
			case AS3Parser.SL:
			case AS3Parser.SR:
			case AS3Parser.BSR:
			case AS3Parser.MINUS:
				return new ASTASBinaryExpression(ast);
			case AS3Parser.POST_DEC:
			case AS3Parser.POST_INC:
				return new ASTASPostfixExpression(ast);
			case AS3Parser.PRE_DEC:
			case AS3Parser.PRE_INC:
			case AS3Parser.UNARY_PLUS:
			case AS3Parser.UNARY_MINUS:
			case AS3Parser.LNOT:
				return new ASTASPrefixExpression(ast);
			//case AS3Parser.IDENT:
			//	return new ASTASSimpleNameExpression(ast);
			case AS3Parser.PROPERTY_OR_IDENTIFIER:
				return new ASTASFieldAccessExpression(ast);
			case AS3Parser.METHOD_CALL:
				return new ASTASInvocationExpression(ast);
			case AS3Parser.ENCPS_EXPR:
				return build(ast.getFirstChild());
			//case AS3Parser.ARRAY_ACC:
			//	return new ASTASArrayAccessExpression(ast);
			case AS3Parser.NEW:
				return new ASTASNewExpression(ast);
			case AS3Parser.QUESTION:
				return new ASTASConditionalExpression(ast);
			case AS3Parser.UNDEFINED:
				return new ASTASUndefinedLiteral(ast);
			case AS3Parser.FUNC_DEF:
				return new ASTASFunctionExpression(ast);
			case AS3Parser.ARRAY_LITERAL:
				return new ASTASArrayLiteral(ast);
			case AS3Parser.OBJECT_LITERAL:
				return new ASTASObjectLiteral(ast);
			case AS3Parser.XML_LITERAL:
				return new ASTASXMLLiteral(ast);
				
				
				
			TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			case AS3Parser.REGEXP_LITERAL:
				return new ASTASRegexpLiteral(ast);
			case AS3Parser.E4X_DESC:
				return new ASTASDescendantExpression(ast);
			case AS3Parser.E4X_FILTER:
				return new ASTASFilterExpression(ast);
			case AS3Parser.E4X_ATTRI_STAR:
				return new ASTASStarAttribute(ast);
			case AS3Parser.E4X_ATTRI_PROPERTY:
				return new ASTASPropertyAttribute(ast);
			case AS3Parser.E4X_ATTRI_EXPR:
				return new ASTASExpressionAttribute(ast);
			default:
				throw new IllegalArgumentException("unhandled expression node type: "+ASTUtils.tokenName(ast));
			*/
		}
	}
}
}