////////////////////////////////////////////////////////////////////////////////
// Copyright 2010 Michael Schmalle - Teoti Graphix, LLC
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software 
// distributed under the License is distributed on an "AS IS" BASIS, 
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and 
// limitations under the License
// 
// Author: Michael Schmalle, Principal Architect
// mschmalle at teotigraphix dot com
////////////////////////////////////////////////////////////////////////////////

package org.as3commons.asblocks.utils
{

import org.as3commons.asblocks.ASBlocksSyntaxError;
import org.as3commons.asblocks.impl.ASTBuilder;
import org.as3commons.asblocks.impl.ASTPrinter;
import org.as3commons.asblocks.impl.TokenBuilder;
import org.as3commons.asblocks.parser.api.AS3NodeKind;
import org.as3commons.asblocks.parser.api.IParser;
import org.as3commons.asblocks.parser.api.IParserNode;
import org.as3commons.asblocks.parser.api.ISourceCode;
import org.as3commons.asblocks.parser.api.IToken;
import org.as3commons.asblocks.parser.core.LinkedListToken;
import org.as3commons.asblocks.parser.core.LinkedListTreeAdaptor;
import org.as3commons.asblocks.parser.core.SourceCode;
import org.as3commons.asblocks.parser.errors.NullTokenError;
import org.as3commons.asblocks.parser.errors.UnExpectedTokenError;
import org.as3commons.asblocks.parser.impl.AS3FragmentParser;
import org.as3commons.asblocks.parser.impl.AS3Parser;
import org.as3commons.asblocks.parser.impl.ASTIterator;
import org.as3commons.mxmlblocks.parser.api.MXMLNodeKind;
import org.as3commons.mxmlblocks.parser.impl.MXMLParser;

/**
 * TODO DOCME
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class ASTUtil
{
	private static var adapter:LinkedListTreeAdaptor = new LinkedListTreeAdaptor();
	
	public static function getLastTagList(ast:IParserNode):IParserNode
	{
		var i:ASTIterator = new ASTIterator(ast);
		var child:IParserNode;
		while (i.hasNext())
		{
			child = i.search(MXMLNodeKind.TAG_LIST);
		}
		
		return child;
	}
	
	public static function findTagStart(ast:IParserNode):LinkedListToken
	{
		if (ast == null)
			return null;
		
		// <tag>\n
		// \t<tag2 ti="s">\n
		// \t</tag2>\n
		// </tag>
		var startAST:IParserNode = ast;
		if (ast.hasKind(MXMLNodeKind.TAG_LIST))
		{
			startAST = getLastTagList(ast);
		}
		
		var tok:LinkedListToken = startAST.startToken;
		while (tok.text != ">")
		{
			if (tok.next == null) 
			{
				break;
			}
			tok = tok.next;
		}
		
		return tok;
	}
	
	public static function findTagStop(ast:IParserNode):LinkedListToken
	{
		if (ast == null)
			return null;
		// <tag>\n
		// \t<tag2 ti="s">\n
		// \t</tag2>\n
		// </tag>
		
		var endAST:IParserNode = ast;
		if (ast.hasKind(MXMLNodeKind.TAG_LIST))
		{
			endAST = getLastTagList(ast);
		}
		
		var tok:LinkedListToken = endAST.stopToken;
		while (tok.text != "</")
		{
			if (tok.previous == null) 
			{
				break;
			}
			tok = tok.previous;
		}
		
		return tok;
	}
	
	public static function findXMLIndent(node:IParserNode):String
	{
		if (node == null)
			return "";
		
		var tok:LinkedListToken = node.startToken;
		tok = tok.next;
		if (!tok)
		{
			return findIndent(node.parent);
		}
		
		// the start-token of this AST node is actually whitespace, so
		// scan forward until we hit a non-WS token,
		while (tok.kind == AS3NodeKind.NL || tok.kind == AS3NodeKind.WS)
		{
			if (tok.next == null) 
			{
				break;
			}
			tok = tok.next;
		}
		// search backwards though the tokens, looking for the start of
		// the line,
		for (; tok.previous != null; tok = tok.previous)
		{
			if (tok.kind == AS3NodeKind.NL)
			{
				break;
			}
		}
		if (tok.kind == AS3NodeKind.WS)
		{
			return tok.text;
		}
		if (tok.kind != AS3NodeKind.NL) 
		{
			return "";
		}
		
		var startOfLine:LinkedListToken = tok.next;
		
		if (startOfLine.kind == AS3NodeKind.WS)
		{
			return startOfLine.text;
		}
		return "";
	}
	
	public static function findIndent(node:IParserNode):String
	{
		var tok:LinkedListToken = node.startToken;
		if (!tok)
		{
			return findIndent(node.parent);
		}
		
		// the start-token of this AST node is actually whitespace, so
		// scan forward until we hit a non-WS token,
		while (tok.kind == AS3NodeKind.NL || tok.kind == AS3NodeKind.WS)
		{
			if (tok.next == null) 
			{
				break;
			}
			tok = tok.next;
		}
		// search backwards though the tokens, looking for the start of
		// the line,
		for (; tok.previous != null; tok = tok.previous)
		{
			if (tok.kind == AS3NodeKind.NL)
			{
				break;
			}
		}
		if (tok.kind == AS3NodeKind.WS)
		{
			return tok.text;
		}
		if (tok.kind != AS3NodeKind.NL) 
		{
			return "";
		}
		
		var startOfLine:LinkedListToken = tok.next;
		
		if (startOfLine.kind == AS3NodeKind.WS)
		{
			return startOfLine.text;
		}
		return "";
	}
	
	public static function newParentheticAST(kind:String, 
											 startKind:String,
											 startText:String,
											 endKind:String,
											 endText:String):IParserNode
	{
		var ast:IParserNode = newAST(kind);
		var start:LinkedListToken = TokenBuilder.newToken(startKind, startText);
		ast.startToken = start;
		var stop:LinkedListToken = TokenBuilder.newToken(endKind, endText);
		ast.stopToken = stop;
		start.next = stop;
		ast.initialInsertionAfter = start;
		return ast;
	}
	
	public static function increaseIndent(node:IParserNode, indent:String):void
	{
		var newStart:LinkedListToken = increaseIndentAt(node.startToken, indent);
		node.startToken = newStart;
		increaseIndentAfterFirstLine(node, indent);
	}
	
	
	public static function increaseIndentAfterFirstLine(node:IParserNode, indent:String):void
	{
		for (var tok:LinkedListToken = node.startToken ; tok != node.stopToken; tok = tok.next)
		{
			switch (tok.kind)
			{
				case AS3NodeKind.NL:
					tok = increaseIndentAt(tok.next, indent);
					break;
				case AS3NodeKind.AS_DOC:
					//					DocCommentUtils.increaseCommentIndent(tok, indent);
					break;
			}
		}
	}
	
	private static function increaseIndentAt(tok:LinkedListToken, indentStr:String):LinkedListToken
	{
		if (tok.kind == AS3NodeKind.WS) 
		{
			tok.text = indentStr + tok.text;
			return tok;
		}
		
		var indent:LinkedListToken = TokenBuilder.newWhiteSpace(indentStr);
		tok.beforeInsert(indent);
		
		return indent;
	}
	
	public static function collapseWhitespace(startToken:LinkedListToken):void
	{
		// takes 2 tokens like "  " to " "
		if (startToken.channel == AS3NodeKind.HIDDEN 
			&& startToken.next.channel == AS3NodeKind.HIDDEN)
		{
			startToken.next.remove();
		}
	}
	
	public static function removeTrailingWhitespaceAndComma(stopToken:LinkedListToken, 
															trim:Boolean = false):void
	{
		for (var tok:LinkedListToken = stopToken.next; tok != null; tok = tok.next)
		{
			if (tok.channel == AS3NodeKind.HIDDEN)
			{
				tok.remove();
			}
			else if (tok.text == ",")
			{
				tok.remove();
				if (trim && stopToken.next.channel == AS3NodeKind.HIDDEN 
					&& stopToken.previous.channel == AS3NodeKind.HIDDEN)
				{
					stopToken.next.remove();
				}
				break;
			}
			else
			{
				throw new ASBlocksSyntaxError("Unexpected token: " + tok);
			}
		}
	}
	
	public static function printNode(ast:IParserNode):String
	{
		var result:String = "";
		for (var tok:LinkedListToken = ast.startToken; tok != null; tok = tok.next)
		{
			result += tok.text;
			if (tok == ast.stopToken)
			{
				break;
			}
		}
		return result;
	}
	
	public static function newAST(kind:String, text:String = null):IParserNode
	{
		return adapter.create(kind, text);
	}
	
	public static function newPrimaryAST(name:String = null):IParserNode
	{
		return adapter.create(AS3NodeKind.PRIMARY, name);
	}
	
	public static function newPrefixAST(op:LinkedListToken):IParserNode
	{
		if (op.kind == AS3NodeKind.PRE_INC)
		{
			return newAST(AS3NodeKind.PRE_INC, op.text);
		}
		else if (op.kind == AS3NodeKind.PRE_DEC)
		{
			return newAST(AS3NodeKind.PRE_DEC, op.text);
		}
		return null;
	}
	
	public static function newPostfixAST(op:LinkedListToken):IParserNode
	{
		if (op.kind == AS3NodeKind.POST_INC)
		{
			return newAST(AS3NodeKind.POST_INC, op.text);
		}
		else if (op.kind == AS3NodeKind.POST_DEC)
		{
			return newAST(AS3NodeKind.POST_DEC, op.text);
		}
		return null;
	}
	
	public static function newBinaryAST(op:LinkedListToken):IParserNode
	{
		if (AS3Parser.additiveMap.containsValue(op.kind))
		{
			return newAST(AS3NodeKind.ADDITIVE);
		}
		else if (AS3Parser.equalityMap.containsValue(op.kind))
		{
			return newAST(AS3NodeKind.EQUALITY);
		}
		else if (AS3Parser.relationMap.containsValue(op.kind))
		{
			return newAST(AS3NodeKind.RELATIONAL);
		}
		else if (AS3Parser.shiftMap.containsValue(op.kind))
		{
			return newAST(AS3NodeKind.SHIFT);
		}
		else if (AS3Parser.multiplicativeMap.containsValue(op.kind))
		{
			return newAST(AS3NodeKind.MULTIPLICATIVE);
		}
		else if (op.kind == AS3NodeKind.LAND)
		{
			return newAST(AS3NodeKind.AND);
		}
		else if (op.kind == AS3NodeKind.LOR)
		{
			return newAST(AS3NodeKind.OR);
		}
		else if (op.kind == AS3NodeKind.BAND)
		{
			return newAST(AS3NodeKind.B_AND);
		}
		else if (op.kind == AS3NodeKind.BOR)
		{
			return newAST(AS3NodeKind.B_OR);
		}
		else if (op.kind == AS3NodeKind.BXOR)
		{
			return newAST(AS3NodeKind.B_XOR);
		}
		return null;
	}
	
	public static function newTokenAST(token:LinkedListToken):IParserNode
	{
		return adapter.createNode(token);
	}
	
	/**
	 * Returns the first child of the given AST node which has the given
	 * type, or null, if no such node exists.
	 */
	public static function findChildByType(ast:IParserNode, kind:String):IParserNode
	{
		return ast.getKind(kind);
	}
	
	public static function newNameAST(name:String):IParserNode
	{
		var ast:IParserNode = newAST(AS3NodeKind.NAME, name);
		return ast;
	}
	
	public static function newTypeAST(type:String):IParserNode
	{
		var ast:IParserNode = newAST(AS3NodeKind.TYPE, type);
		return ast;
	}
	
	public static function newInitAST(defaultValue:String):IParserNode
	{
		var ast:IParserNode = newAST(AS3NodeKind.INIT);
		var init:IParserNode = AS3FragmentParser.parsePrimaryExpression(defaultValue);
		ast.addChild(init);
		return ast;
	}
	
	public static function newParamterListAST():IParserNode
	{
		var ast:IParserNode = newAST(AS3NodeKind.PARAMETER_LIST);
		return ast;
	}
	
	public static function newParamterAST():IParserNode
	{
		var ast:IParserNode = newAST(AS3NodeKind.PARAMETER);
		ast.addChild(newAST(AS3NodeKind.NAME_TYPE_INIT));
		return ast;
	}
	
	public static function addChildWithIndentation(ast:IParserNode, 
												   stmt:IParserNode,
												   index:int = -1):void
	{
		var last:IParserNode = ast.getLastChild();
		var indent:String;
		if (last == null)
		{
			indent = "\t" + findIndent(ast);
		}
		else
		{
			indent = findIndent(last);
		}
		
		increaseIndent(stmt, indent);
		stmt.addTokenAt(TokenBuilder.newNewline(), 0);
		if (index == -1)
		{
			ast.addChild(stmt);
		}
		else
		{
			ast.addChildAt(stmt, index);
		}
	}
	
	
	public static function removePreceedingWhitespaceAndComma(startToken:LinkedListToken):void
	{
		for (var tok:LinkedListToken = startToken.previous; tok != null; tok = tok.previous)
		{
			if (tok.channel == AS3NodeKind.HIDDEN) 
			{
				var del:LinkedListToken = tok;
				tok = tok.next;
				del.remove();
				continue;
			} 
			else if (tok.kind == "comma")
			{
				tok.remove();
				break;
			}
			else
			{
				throw new ASBlocksSyntaxError("Unexpected token: " + tok);
			}
		}
	}
	
	public static function removeAllChildren(ast:IParserNode):void
	{
		while (ast.numChildren > 0)
		{
			ast.removeChildAt(0);
		}
	}
	
	public static function nameText(ast:IParserNode):String
	{
		if (!ast)
			return null;
		
		// NAME node, I want to change ast some day
		return ast.stringValue;
	}
	
	public static function typeText(ast:IParserNode):String
	{
		if (!ast)
			return null;
		
		// TYPE node, I want to change ast some day
		return ast.stringValue;
	}
	
	public static function initText(ast:IParserNode):String
	{
		if (!ast)
			return null;
		
		// TYPE node, I want to change ast some day
		return stringifyNode(ast);
	}
	
	/**
	 * Converts an <code>IParserNode</code> into a flat XML String.
	 * 
	 * @param ast The <code>IParserNode</code> to convert.
	 * @return A String XML representation of the <code>IParserNode</code>.
	 */
	public static function convert(ast:IParserNode, 
								   location:Boolean = true):String
	{
		return visitNodes(ast, "", 0, location);
	}
	
	
	public static function decodeStringLiteral(string:String):String
	{
		var result:String = "";
		
		if (string.indexOf('"') != 0 && string.indexOf("'") != 0)
		{
			throw new ASBlocksSyntaxError("Invalid delimiter at position 0: " + string[0]);
		}
		
		var chars:Array = string.split("");
		
		var delimiter:String = chars[0];
		var end:int = chars.length - 1;
		for (var i:int = 1; i < end; i++) 
		{
			var c:String = chars[i];
			switch (c) 
			{
				case '\\':
					
					c = chars[++i];
					switch (c) 
					{
						case 'n':
							result += '\n';
							break;
						case 't':
							result += '\t';
							break;
						case '\\':
							result += '\\';
							break;
						default:
							result += c;
					}
					break;
				
				default:
					result += c;
			}
		}
		
		if (chars[end] != delimiter) 
		{
			throw new ASBlocksSyntaxError("End delimiter doesn't match " + delimiter + " at position " + end);
		}
		
		return result;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Private Class :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private static function visitNodes(ast:IParserNode, 
									   result:String, 
									   level:int,
									   location:Boolean = true):String
	{
		if (location)
		{
			result += "<" + ast.kind + " line=\"" + 
				ast.line + "\" column=\"" + ast.column + "\">";
		}
		else
		{
			result += "<" + ast.kind + ">";
		}
		
		var numChildren:int = ast.numChildren;
		if (numChildren > 0)
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				result = visitNodes(ast.getChild(i), result, level + 1, location);
			}
		}
		else if (ast.stringValue != null)
		{
			result += escapeEntities(ast.stringValue);
		}
		
		result += "</" + ast.kind + ">";
		
		return result;
	}
	
	/**
	 * @private
	 */
	private static function escapeEntities(stringToEscape:String):String
	{
		var buffer:String = "";
		
		for (var i:int = 0; i < stringToEscape.length; i++)
		{
			var currentCharacter:String = stringToEscape.charAt(i);
			
			if (currentCharacter == '<')
			{
				buffer += "&lt;";
			}
			else if (currentCharacter == '>')
			{
				buffer += "&gt;";
			}
			else
			{
				buffer += currentCharacter;
			}
		}
		return buffer;
	}
	
	public static function stringifyNode(ast:IParserNode):String
	{
		var result:String = "";
		for (var tok:LinkedListToken =  ast.startToken; tok != null && tok.kind != null; tok = tok.next)
		{
			if (tok.text != null)
			{
				result += tok.text;
			}
			
			if (tok == ast.stopToken)
			{
				break;
			}
		}
		return result;
	}
	
	public static function tokenName(kind:String):String
	{
		return kind;
	}
	

	
	public static function parse(code:ISourceCode):AS3Parser
	{
		var parser:AS3Parser = new AS3Parser();
		var source:String = code.code;
		source = source.split("\r\n").join("\n");
		parser.scanner.setLines(Vector.<String>(source.split("\n")));
		return parser;
		
	}
	
	public static function parseMXML(code:ISourceCode):MXMLParser
	{
		var parser:MXMLParser = new MXMLParser();
		var source:String = code.code;
		source = source.split("\r\n").join("\n");
		parser.scanner.setLines(Vector.<String>(source.split("\n")));
		return parser;
		
	}
	
	public static function constructSyntaxError(statement:String, 
												parser:IParser,
												cause:Error):ASBlocksSyntaxError
	{
		var message:String = "";
		if (cause is UnExpectedTokenError)
		{
			message = cause.message;
		}
		else if (cause is NullTokenError)
		{
			message = cause.message;
		}
		else
		{
			if (!statement)
			{
				message = "";
			}
			else
			{
				message = "Problem parsing " + ASTBuilder.escapeString(statement);
			}
		}
		return new ASBlocksSyntaxError(message, cause);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Node :: Methods
	//
	//--------------------------------------------------------------------------
	
	public static function getNodes(kind:String, node:IParserNode):Vector.<IParserNode>
	{
		var result:Vector.<IParserNode> = new Vector.<IParserNode>();
		
		if (node.numChildren == 0)
			return result;
		
		var len:int = node.children.length;
		for (var i:int = 0; i < len; i++)
		{
			var element:IParserNode = node.children[i] as IParserNode;
			if (element.isKind(kind))
				result.push(element)
		}
		
		return result;
	}
	
	public static function findIndentForXMLComment(ast:IParserNode):String
	{
		var last:IParserNode = ast.getLastChild();
		var indent:String;
		if (last == null)
		{
			indent = "\t" + findXMLIndent(ast);
		}
		else
		{
			indent = findXMLIndent(last);
		}
		return indent;
	}
	
	public static function findIndentForComment(ast:IParserNode):String
	{
		var last:IParserNode = ast.getLastChild();
		var indent:String;
		if (last == null)
		{
			indent = "\t" + findIndent(ast);
		}
		else
		{
			indent = findIndent(last);
		}
		return indent;
	}
	
	public static function print(node:IParserNode):String
	{
		var printer:ASTPrinter = new ASTPrinter(new SourceCode());
		printer.print(node);
		return printer.flush();
	}
	
	public static function removeComment(ast:IParserNode):IToken
	{
		// nl, sl-comment, ws, nl
		var comment:LinkedListToken = getComment(ast);
		if (!comment)
		{
			return null;
		}
		
		var ws:LinkedListToken = comment.previous;
		var nl:LinkedListToken = ws.previous;
		
		nl.remove();
		ws.remove();
		comment.remove();
		
		return comment;
	}
	
	private static function getComment(ast:IParserNode):LinkedListToken
	{
		for (var tok:LinkedListToken =  ast.startToken; tok != null; tok = tok.previous)
		{
			if (tok.kind == "sl-comment")
				return tok;
		}
		return null;
	}
	
	
}
}