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

package org.teotigraphix.asblocks.impl
{

import org.teotigraphix.as3parser.api.AS3NodeKind;
import org.teotigraphix.as3parser.api.IParserNode;
import org.teotigraphix.asblocks.api.IParameter;
import org.teotigraphix.asblocks.utils.ASTUtil;

/**
 * The <code>IParameter</code> implementation.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class ParameterNode extends ScriptNode implements IParameter
{
	//--------------------------------------------------------------------------
	//
	//  IParameter API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  description
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IParameter#description
	 */
	public function get description():String
	{
		return null;
	}
	
	/**
	 * @private
	 */	
	public function set description(value:String):void
	{
		// TODO impl
	}
	
	//----------------------------------
	//  name
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IParameter#name
	 */
	public function get name():String
	{
		if (isRest)
			return findRest().stringValue;
		
		var ast:IParserNode = findNameTypeInit();
		var name:IParserNode = ast.getKind(AS3NodeKind.NAME);
		if (name)
			return ASTUtil.nameText(name);
		
		// IllegalStateException
		throw new Error("No parameter name, and not a 'rest' parameter");
	}
	
	/**
	 * @private
	 */	
	public function set name(value:String):void
	{
		if (isRest)
		{
			findRest().stringValue = value;
			return;
		}
		
		var ast:IParserNode = findNameTypeInit();
		var name:IParserNode = ast.getKind(AS3NodeKind.NAME);
		if (name)
			name.stringValue = value;
	}
	
	//----------------------------------
	//  type
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IParameter#type
	 */
	public function get type():String
	{
		if (isRest)
			return null;
	
		var ast:IParserNode = findNameTypeInit();
		var type:IParserNode = ast.getKind(AS3NodeKind.TYPE);
		if (type)
			return ASTUtil.typeText(type);
	
		return null;
	}
	
	/**
	 * @private
	 */	
	public function set type(value:String):void
	{
		if (isRest)
			return;
		
		var ast:IParserNode = findNameTypeInit();
		var typeAST:IParserNode = ast.getKind(AS3NodeKind.TYPE);
		if (typeAST)
			typeAST.stringValue = value;
	}
	
	//----------------------------------
	//  hasType
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IParameter#hasType
	 */
	public function get hasType():Boolean
	{
		var ast:IParserNode = findNameTypeInit();
		var type:IParserNode = ast.getKind(AS3NodeKind.TYPE);
		return type != null;
	}
	
	//----------------------------------
	//  defaultValue
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IParameter#defaultValue
	 */
	public function get defaultValue():String
	{
		if (isRest)
			return null;
		
		var ast:IParserNode = findNameTypeInit();
		var init:IParserNode = ast.getKind(AS3NodeKind.INIT);
		if (init)
			return ASTUtil.initText(init);
		
		return null;
	}
	
	/**
	 * @private
	 */	
	public function set defaultValue(value:String):void
	{
		if (isRest)
			return;
		
		var ast:IParserNode = findNameTypeInit();
		var initAST:IParserNode = ast.getKind(AS3NodeKind.INIT);
		if (!initAST)
		{
			initAST = ASTUtil.newAST(AS3NodeKind.INIT);
			ast.addChild(initAST);
		}
		
		initAST.stringValue = value;
	}
	
	//----------------------------------
	//  hasDefaultValue
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IParameter#hasDefaultValue
	 */
	public function get hasDefaultValue():Boolean
	{
		if (isRest)
			return false;
		
		return defaultValue != null;
	}
	
	//----------------------------------
	//  isRest
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IParameter#isRest
	 */
	public function get isRest():Boolean
	{
		return node.hasKind(AS3NodeKind.REST);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ParameterNode(node:IParserNode)
	{
		super(node);
	}
	
	/**
	 * @private
	 */
	private function findNameTypeInit():IParserNode
	{
		return node.getKind(AS3NodeKind.NAME_TYPE_INIT);
	}
	
	/**
	 * @private
	 */
	private function findRest():IParserNode
	{
		return node.getKind(AS3NodeKind.REST);
	}
}
}