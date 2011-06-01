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

package org.as3commons.asblocks.parser.core
{

import org.as3commons.asblocks.parser.api.IToken;

/**
 * A Token represents a piece of text in a string of data with location
 * properties.
 * 
 * <p>Initial API; Adobe Systems, Incorporated</p>
 * 
 * @author Adobe Systems, Incorporated
 * @author Michael Schmalle
 * @productversion 1.0
 */
public class Token implements IToken
{
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  column
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _column:int;
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.IToken#column
	 */
	public final function get column():int
	{
		return _column;
	}
	
	/**
	 * @private
	 */
	public final function set column(value:int):void
	{
		_column = value;
	}
	
	//----------------------------------
	//  line
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _line:int;
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.IToken#line
	 */
	public final function get line():int
	{
		return _line;
	}
	
	/**
	 * @private
	 */
	public final function set line(value:int):void
	{
		_line = value;
	}
	
	//----------------------------------
	//  kind
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _kind:String;
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.IToken#kind
	 */
	public final function get kind():String
	{
		return _kind;
	}
	
	/**
	 * @private
	 */
	public final function set kind(value:String):void
	{
		_kind = value;
	}
	
	//----------------------------------
	//  text
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _text:String;
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.IToken#text
	 */
	public final function get text():String
	{
		return _text;
	}
	
	/**
	 * @private
	 */
	public final function set text(value:String):void
	{
		_text = value;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	public function Token(text:String, line:int = -1, column:int = -1)
	{
		_text = text;
		_line = line + 1;
		_column = column + 1;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public Class :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Creates a new Token.
	 * 
	 * @param text The Token text String.
	 * @param line The line number the Token is found on.
	 * @param column The column the Token starts at.
	 * @return A new Token instance.
	 */
	public static function create(text:String, 
								  line:int = -1, 
								  column:int = -1):Token
	{
		return new Token(text, line, column);
	}
}
}