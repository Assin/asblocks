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

package org.teotigraphix.asblocks.api
{

import org.teotigraphix.as3parser.api.AS3NodeKind;
import org.teotigraphix.as3parser.core.LinkedListToken;
import org.teotigraphix.as3parser.core.Token;

/**
 * Prefix operators.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public final class PrefixOperator
{
	//--------------------------------------------------------------------------
	//
	//  Public :: Constants
	//
	//--------------------------------------------------------------------------
	
	public static const PREDEC:PrefixOperator = PrefixOperator.create("--");
	
	public static const PREINC:PrefixOperator = PrefixOperator.create("++");
	
	private static var list:Array =
		[
			PREDEC,
			PREINC
		];
	
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
	 * @private
	 */
	public static function create(name:String):PrefixOperator
	{
		for each (var element:PrefixOperator in list) 
		{
			if (element.name == name)
				return element;
		}
		
		return new PrefixOperator(name);
	}
	
	/**
	 * @private
	 */
	public static function find(type:String):PrefixOperator
	{
		for each (var element:PrefixOperator in list) 
		{
			if (element.name == type)
				return element;
		}
		return null;
	}
	
	/**
	 * @private
	 */
	public static function initialize(operator:PrefixOperator, token:Token):void
	{
		var ltok:LinkedListToken = token as LinkedListToken;
		var op:PrefixOperator = find(operator.name);
		if (!op)
			return;	
		
		ltok.text = op.name;
		ltok.kind = AS3NodeKind.OP;
	}
}
}