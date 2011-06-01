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

import flash.errors.IllegalOperationError;

import org.as3commons.asblocks.ASBlocksSyntaxError;
import org.as3commons.asblocks.parser.api.ILinkedListToken;

/**
 * A linked list token implementation.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class LinkedListToken extends Token implements ILinkedListToken
{
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  channel
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _channel:String;
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.ILinkedListToken#channel
	 */
	public function get channel():String
	{
		if (_channel == null)
		{
			if (text == "\n" || text == "\n" || text == " ")
				return "hidden";
		}
		return _channel;
	}
	
	/**
	 * @private
	 */	
	public function set channel(value:String):void
	{
		_channel = value;
	}
	
	//----------------------------------
	//  previous
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _previous:LinkedListToken;
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.ILinkedListToken#previous
	 */
	public function get previous():ILinkedListToken
	{
		return _previous;
	}
	
	/**
	 * @private
	 */	
	public function set previous(value:ILinkedListToken):void
	{
		if (this == value)
			throw new ASBlocksSyntaxError("Loop detected");
		
		_previous = value as LinkedListToken;
		
		if (_previous)
		{
			_previous.setNext(this);
		}
	}
		
	/**
	 * @private
	 */	
	internal function setPrevious(value:LinkedListToken):void
	{
		_previous = value;
	}	
	
	//----------------------------------
	//  next
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _next:LinkedListToken;
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.ILinkedListToken#next
	 */
	public function get next():ILinkedListToken
	{
		return _next;
	}
	
	/**
	 * @private
	 */	
	public function set next(value:ILinkedListToken):void
	{
		if (this == value)
			throw new ASBlocksSyntaxError("Loop detected");
		
		_next = value as LinkedListToken;
		
		if (_next)
		{
			_next.setPrevious(this);
		}
	}
		
	/**
	 * @private
	 */	
	internal function setNext(value:LinkedListToken):void
	{
		_next = value;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function LinkedListToken(kind:String, 
									text:String, 
									line:int = -1, 
									column:int = -1)
	{
		super(text, line, column);
		
		this.kind = kind;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.ILinkedListToken#append()
	 */
	public function append(token:ILinkedListToken):void
	{
		// token, token, this, [after], token, token
		if (token.previous)
			throw new IllegalOperationError("append(" + token + ") : previous was not null");
		
		if (token.next)
			throw new IllegalOperationError("append(" + next + ") : previous was not null");
		
		var ltoken:LinkedListToken = token as LinkedListToken;
		if (!ltoken)
			return;
		
		ltoken.setNext(_next);
		ltoken.setPrevious(this);
		
		if (_next)
		{
			_next.setPrevious(ltoken);
		}
		
		_next = ltoken;
	}
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.ILinkedListToken#prepend()
	 */
	public function prepend(token:ILinkedListToken):void
	{
		// token, token, [before], this, token, token
		if (token.previous)
			throw new IllegalOperationError("prepend(" + token + ") : previous was not null");
		
		if (token.next)
			throw new IllegalOperationError("prepend(" + next + ") : previous was not null");
		
		var ltoken:LinkedListToken = token as LinkedListToken;
		if (!ltoken)
			return;
		
		ltoken.setPrevious(_previous);
		ltoken.setNext(this);
		
		if (_previous)
		{
			_previous.setNext(ltoken);
		}
		
		_previous = ltoken;
	}
	
	/**
	 * @copy org.as3commons.asblocks.parser.api.ILinkedListToken#remove()
	 */
	public function remove():void
	{
		if (_previous)
		{
			_previous.setNext(_next);
		}
		
		if (_next)
		{
			_next.setPrevious(_previous);
		}
		
		_next = null;
		_previous = null;
	}
}
}