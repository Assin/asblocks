package org.teotigraphix.asblocks.impl
{

import org.teotigraphix.as3parser.api.AS3NodeKind;
import org.teotigraphix.as3parser.api.IParserNode;
import org.teotigraphix.as3parser.impl.AS3FragmentParser;
import org.teotigraphix.asblocks.api.IArgumentNode;
import org.teotigraphix.asblocks.api.IFunctionCommon;
import org.teotigraphix.asblocks.utils.ASTUtil;

public class FunctionCommon implements IFunctionCommon
{
	private var node:IParserNode;
	
	//--------------------------------------------------------------------------
	//
	//  IFunctionCommon API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  arguments
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _arguments:Vector.<IArgumentNode>;
	
	/**
	 * doc
	 */
	public function get arguments():Vector.<IArgumentNode>
	{
		return _arguments;
	}
	
	//----------------------------------
	//  type
	//----------------------------------
	
	/**
	 * doc
	 */
	public function get type():String
	{
		var t:IParserNode = node.getKind(AS3NodeKind.TYPE);
		if (t)
			return ASTUtil.typeText(t);
		return null;
	}
	
	/**
	 * @private
	 */	
	public function set type(value:String):void
	{
		// lambda/name-type-int/type
		var nameTypeInit:IParserNode = node.getKind(AS3NodeKind.NAME_TYPE_INIT);
		var existingType:IParserNode = nameTypeInit.getKind(AS3NodeKind.TYPE);
		if (value == null)
		{
			if (existingType != null)
			{
				nameTypeInit.removeChild(existingType);
			}
			return;
		}
		
		var newType:IParserNode = AS3FragmentParser.parseType(value);
		if (nameTypeInit == null) // SHOULDN'T BE
		{
			
		}
		else
		{
			nameTypeInit.setChildAt(newType, 0);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function FunctionCommon(node:IParserNode)
	{
		super();
		
		this.node = node;
	}
	
	//--------------------------------------------------------------------------
	//
	//  IFunctionCommon API :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * TODO Docme
	 */
	public function addParameter(name:String, 
								 type:String, 
								 defaultValue:String = null):IArgumentNode
	{
		var ast:IParserNode = ASTUtil.newParamterAST();
		ast.addChild(ASTUtil.newNameAST(name));
		ast.appendToken(TokenBuilder.newColumn());
		ast.addChild(ASTUtil.newTypeAST(type));
		if (defaultValue)
		{
			ast.appendToken(TokenBuilder.newSpace());
			ast.appendToken(TokenBuilder.newEqual());
			ast.appendToken(TokenBuilder.newSpace());
			ast.addChild(ASTUtil.newInitAST(defaultValue));
		}
		return createParameter(ast);
	}
	
	private function createParameter(ast:IParserNode):IArgumentNode
	{
		var paramList:IParserNode = node.getKind(AS3NodeKind.PARAMETER_LIST);
		if (paramList.numChildren > 0)
		{
			paramList.appendToken(TokenBuilder.newComma());
			paramList.appendToken(TokenBuilder.newSpace());
		}
		paramList.addChild(ast);
		return new ArgumentNode(ast);
	}
	
	/**
	 * TODO Docme
	 */
	public function removeParameter(name:String):IArgumentNode
	{
		return null;
	}
	
	/**
	 * TODO Docme
	 */
	public function addRestParam(name:String):IArgumentNode
	{
		return null;
	}
}
}