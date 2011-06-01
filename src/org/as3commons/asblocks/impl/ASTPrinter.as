package org.as3commons.asblocks.impl
{

import org.as3commons.asblocks.parser.api.ILinkedListToken;
import org.as3commons.asblocks.parser.api.IParserNode;
import org.as3commons.asblocks.parser.api.ISourceCode;
import org.as3commons.asblocks.parser.core.LinkedListToken;
import org.as3commons.asblocks.parser.core.SourceCode;

public class ASTPrinter
{
	private var sourceCode:ISourceCode;
	
	public function ASTPrinter(sourceCode:ISourceCode)
	{
		this.sourceCode = sourceCode;
	}
	
	public function print(ast:IParserNode):void
	{
		for (var tok:ILinkedListToken = findStart(ast); tok != null; tok = tok.next)
		{
			printLn(tok);
		}
	}
	
	private function findStart(ast:IParserNode):ILinkedListToken
	{
		var result:ILinkedListToken = null;
		
		for (var tok:ILinkedListToken = ast.startToken; viable(tok); tok = tok.previous)
		{
			result = tok;
		}
		return result;
	}
	
	private function printLn(token:ILinkedListToken):void
	{
		if (!sourceCode.code)
			sourceCode.code = "";
		
		if (token.text != null)
			sourceCode.code += token.text;
	}
	
	private function viable(token:ILinkedListToken):Boolean
	{
		return token != null && token.kind != "__END__";
	}
	
	public function flush():String
	{
		var result:String = toString();
		sourceCode.code = null;
		return result;
	}
	
	public function toString():String
	{
		return sourceCode.code;
	}
}
}