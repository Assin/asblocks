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
import org.teotigraphix.asblocks.api.IMetaDataParameter;

/**
 * The <code>IMetaDataParameter</code> implementation.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class MetaDataParameterNode extends ScriptNode 
	implements IMetaDataParameter
{
	//--------------------------------------------------------------------------
	//
	//  IMetaDataParameter API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  value
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IMetaDataParameter#value
	 */
	public function get value():String
	{
		return null;
	}
	
	//----------------------------------
	//  name
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IMetaDataParameter#name
	 */
	public function get name():String
	{
		return null;
	}
	
	//----------------------------------
	//  label
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IMetaDataParameter#hasName
	 */
	public function get hasName():Boolean
	{
		return false;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function MetaDataParameterNode(node:IParserNode)
	{
		super(node);
	}
}
}