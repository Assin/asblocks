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

package org.teotigraphix.as3nodes.api
{

/**
 * The ITypeNode represents a class or interface node.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface ITypeNode extends INode, 
	IMetaDataAware, ICommentAware, IVisible, INameAware
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  constants
	//----------------------------------
	
	/**
	 * The type's IConstantNode children.
	 */
	function get constants():Vector.<IConstantNode>;
	
	//----------------------------------
	//  attributes
	//----------------------------------
	
	/**
	 * The type's IAttributeNode children.
	 */
	function get attributes():Vector.<IAttributeNode>;
	
	//----------------------------------
	//  accessors
	//----------------------------------
	
	/**
	 * The type's IAccessorNode children.
	 */
	function get accessors():Vector.<IAccessorNode>;
	
	//----------------------------------
	//  functions
	//----------------------------------
	
	/**
	 * The type's IMethodNode children.
	 */
	function get methods():Vector.<IMethodNode>;
}
}