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

package org.teotigraphix.as3nodes.impl
{

import org.teotigraphix.as3nodes.api.IFunctionNode;
import org.teotigraphix.as3nodes.api.IIdentifierNode;
import org.teotigraphix.as3nodes.api.IMethodNode;
import org.teotigraphix.as3nodes.api.INode;
import org.teotigraphix.as3nodes.api.IParameterNode;
import org.teotigraphix.as3nodes.api.ITypeNode;
import org.teotigraphix.as3nodes.api.Modifier;
import org.teotigraphix.as3nodes.utils.NodeUtil;
import org.teotigraphix.as3parser.api.AS3NodeKind;
import org.teotigraphix.as3parser.api.IParserNode;
import org.teotigraphix.as3parser.utils.ASTUtil;

/**
 * TODO DOCME
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class FunctionNode extends ScriptNode implements IFunctionNode
{
	//--------------------------------------------------------------------------
	//
	//  IFunctionNode API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  isConstructor
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _isConstructor:Boolean;
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IFunctionNode#isConstructor
	 */
	public function get isConstructor():Boolean
	{
		return _isConstructor;
	}
	
	//----------------------------------
	//  isOverride
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IFunctionNode#isOverride
	 */
	public function get isOverride():Boolean
	{
		return hasModifier(Modifier.OVERRIDE);
	}
	
	//--------------------------------------------------------------------------
	//
	//  IParameterAware API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  parameters
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _parameters:Vector.<IParameterNode>;
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IParameterAware#parameters
	 */
	public function get parameters():Vector.<IParameterNode>
	{
		return _parameters;
	}
	
	/**
	 * @private
	 */	
	public function set parameters(value:Vector.<IParameterNode>):void
	{
		_parameters = value;
	}
	
	//----------------------------------
	//  hasParameters
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IParameterAware#hasParameters
	 */
	public function get hasParameters():Boolean
	{
		return _parameters && _parameters.length > 0;
	}
	
	//--------------------------------------------------------------------------
	//
	//  IFunctionNode API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  type
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _type:IIdentifierNode;
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IFunctionNode#hasParameters
	 */
	public function get type():IIdentifierNode
	{
		return _type;
	}
	
	/**
	 * @private
	 */	
	public function set type(value:IIdentifierNode):void
	{
		_type = value;
	}
	
	//----------------------------------
	//  hasType
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IFunctionNode#hasType
	 */
	public function get hasType():Boolean
	{
		return type != null;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function FunctionNode(node:IParserNode, parent:INode)
	{
		super(node, parent);
	}
	
	//--------------------------------------------------------------------------
	//
	//  IParameterAware API :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IParameterAware#addParameter()
	 */
	public function addParameter(parameter:IParameterNode):void
	{
		if (!_parameters)
			_parameters = new Vector.<IParameterNode>();
		
		_parameters.push(parameter);
	}
	
	/**
	 * @copy org.teotigraphix.as3nodes.api.IParameterAware#getParameter()
	 */
	public function getParameter(name:String):IParameterNode
	{
		for each (var element:IParameterNode in parameters)
		{
			if (element.name == name)
				return element;
		}
		return null;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	override protected function compute():void
	{
		super.compute();
		
		if (node.numChildren == 0)
			return;
		
		for each (var child:IParserNode in node.children)
		{
			if (child.isKind(AS3NodeKind.PARAMETER_LIST))
			{
				computeParameterList(child);
			}
			else if (child.isKind(AS3NodeKind.TYPE))
			{
				computeType(child);
			}
		}
		
		var parentType:ITypeNode = parent as ITypeNode;
		if (parentType)
		{
			if (parentType.name == name)
				_isConstructor = true;
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	protected function computeParameterList(child:IParserNode):void
	{
		NodeUtil.computeParameterList(this, child);
	}
	
	/**
	 * @private
	 */
	protected function computeType(child:IParserNode):void
	{
		NodeUtil.computeReturnType(this, child);
	}
}
}