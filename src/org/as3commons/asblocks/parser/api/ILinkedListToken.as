////////////////////////////////////////////////////////////////////////////////
// Copyright 2011 Michael Schmalle - Teoti Graphix, LLC
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

package org.as3commons.asblocks.parser.api
{

/**
 * A token located in a token list with next and previous tokens.
 * 
 * @author Michael Schmalle
 * @productversion 1.0
 */
public interface ILinkedListToken extends IToken
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  channel
	//----------------------------------
	
	/**
	 * The token's channel.
	 */
	function get channel():String;
	
	/**
	 * @private
	 */
	function set channel(value:String):void;
	
	//----------------------------------
	//  previous
	//----------------------------------
	
	/**
	 * The token's previous linked token.
	 * 
	 * @throws ASBlocksSyntaxError Loop detected
	 */
	function get previous():ILinkedListToken;
	
	/**
	 * @private
	 */
	function set previous(value:ILinkedListToken):void;
	
	//----------------------------------
	//  next
	//----------------------------------
	
	/**
	 * The token's next linked token.
	 * 
	 * @throws ASBlocksSyntaxError Loop detected
	 */
	function get next():ILinkedListToken;
	
	/**
	 * @private
	 */
	function set next(value:ILinkedListToken):void;
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Adds the <code>token</code> token after this token.
	 * 
	 * @param before The prepended token.
	 * @throws IllegalOperationError
	 */
	function append(token:ILinkedListToken):void;
		
	/**
	 * Adds the <code>token</code> token before this token.
	 * 
	 * @param token The prepended token.
	 * @throws IllegalOperationError
	 */
	function prepend(token:ILinkedListToken):void;
		
	/**
	 * Removes this token from the token list.
	 */
	function remove():void;
}
}