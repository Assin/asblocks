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

import org.teotigraphix.as3parser.api.IParserNode;
import org.teotigraphix.asblocks.api.ICatchClause;
import org.teotigraphix.asblocks.api.IStatementContainer;

/**
 * The <code>ICatchClause</code> implementation.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class CatchClause extends ContainerDelegate 
	implements ICatchClause
{
	override protected function get statementContainer():IStatementContainer
	{
		return new StatementList(node.getFirstChild()); // block
	}
	
	//--------------------------------------------------------------------------
	//
	//  ICatchClause API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  name
	//----------------------------------
	
	/**
	 * doc
	 */
	public function get name():String
	{
		return null;
	}
	
	/**
	 * @private
	 */	
	public function set name(value:String):void
	{
	}
	
	//----------------------------------
	//  type
	//----------------------------------
	
	/**
	 * doc
	 */
	public function get type():String
	{
		return null;
	}
	
	/**
	 * @private
	 */	
	public function set type(value:String):void
	{
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function CatchClause(node:IParserNode)
	{
		super(node);
	}
}
}