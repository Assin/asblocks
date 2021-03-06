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

package org.as3commons.asblocks.api
{

import flash.errors.IllegalOperationError;

import org.as3commons.asblocks.parser.api.AS3NodeKind;
import org.as3commons.asblocks.parser.api.IToken;
import org.as3commons.asblocks.parser.core.LinkedListToken;
import org.as3commons.asblocks.utils.ASTUtil;
import org.as3commons.collections.Map;
import org.as3commons.collections.framework.IMap;

/**
 * Prefix operators.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public final class PrefixOperator
{
	private static var OPERATORS_BY_TYPE:IMap = new Map();
	
	private static var TYPES_BY_OPERATOR:IMap = new Map();
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Constants
	//
	//--------------------------------------------------------------------------
	
	
	public static const PREDEC:PrefixOperator = PrefixOperator.create("PREDEC");
	
	public static const PREINC:PrefixOperator = PrefixOperator.create("PREINC");
	
	
	private static var intialized:Boolean = false;
	
	private static function initialize():void
	{
		if (intialized)
			return;
		
		mapOp(AS3NodeKind.PRE_DEC, "--", PrefixOperator.PREDEC);
		mapOp(AS3NodeKind.PRE_INC, "++", PrefixOperator.PREINC);
		
		intialized = true;
	}
	
	private static function mapOp(kind:String, text:String, operator:PrefixOperator):void
	{
		OPERATORS_BY_TYPE.add(kind, operator);
		TYPES_BY_OPERATOR.add(operator, new LinkedListToken(kind, text));
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  name
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _name:String;
	
	/**
	 * The operator name.
	 */
	public function get name():String
	{
		return _name;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	public function PrefixOperator(name:String)
	{
		_name = name;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	public function toString():String
	{
		return _name;
	}
	
	/**
	 * @private
	 */
	public function equals(other:PrefixOperator):Boolean
	{
		return _name == other.name;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public Class :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Creates a new PrefixOperator.
	 * 
	 * @param name A String indicating the name of the PrefixOperator.
	 * @return A new PrefixOperator instance.
	 */
	private static function create(name:String):PrefixOperator
	{
		return new PrefixOperator(name);
	}
	
	public static function opFromKind(kind:String):PrefixOperator
	{
		if (!intialized)
		{
			initialize();
		}
		
		var op:PrefixOperator = OPERATORS_BY_TYPE.itemFor(kind);
		if (op == null) 
		{
			throw new IllegalOperationError("No operator for token-type '" + 
				ASTUtil.tokenName(kind) + "'");
		}
		return op;
	}
	
	public static function initializeFromOp(operator:PrefixOperator, tok:IToken):void
	{
		if (!intialized)
		{
			initialize();
		}
		
		var type:LinkedListToken = TYPES_BY_OPERATOR.itemFor(operator);
		if (type == null) 
		{
			throw new IllegalOperationError("No operator for Op " + operator);
		}
		tok.kind = type.kind;
		tok.text = type.text;
	}
}
}