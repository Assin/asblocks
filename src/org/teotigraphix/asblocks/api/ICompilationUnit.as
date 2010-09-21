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

/**
 * The <code>ICompilationUnit</code> is the toplevel AST wrapper class that 
 * contains a public <code>IPackage</code> and the package contains a
 * public <code>IType</code>.
 * 
 * <p>Although the <code>typeNode</code> is not actually a child of the 
 * compilation unit, the <code>typeNode</code> property is available
 * for a shortcut instead of going through the <code>packageNode</code>.</p>
 * 
 * <p>The <code>packageName</code> also references the <code>packageNode.name</code>
 * and is not found on this AST.</p>
 * 
 * <pre>
 * var factory:ASFactory = new ASFactory();
 * var project:IASProject = new ASFactory(factory);
 * var unit:ICompilationUnit = project.newClass("my.domain.ClassType");
 * </pre>
 * 
 * <p>Will produce;</p>
 * <pre>
 * package my.domain {
 * 	public class ClassType {
 * 	}
 * }
 * </pre>
 * 
 * <pre>
 * var factory:ASFactory = new ASFactory();
 * var project:IASProject = new ASFactory(factory);
 * var unit:ICompilationUnit = project.newInterface("my.domain.IInterfaceType");
 * </pre>
 * 
 * <p>Will produce;</p>
 * <pre>
 * package my.domain {
 * 	public interface IInterfaceType {
 * 	}
 * }
 * </pre>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface ICompilationUnit extends IScriptNode
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  packageNode
	//----------------------------------
	
	/**
	 * The public <code>package</code> node of the compilation unit.
	 * 
	 * <p>This node holds the public <code>IType</code> node.</p>
	 */
	function get packageNode():IPackage;
	
	//----------------------------------
	//  packageName
	//----------------------------------
	
	/**
	 * The qualified name of the package (<code>my</code>,
	 * <code>my.domain</code> or <code>null</code>).
	 * 
	 * <p>This property can also be <code>null</code> which means the compilation
	 * unit is located in the default <code>toplevel</code> package.</p>
	 * 
	 * @see org.teotigraphix.asblocks.api.IPackage#name
	 */
	function get packageName():String;
	
	/**
	 * @private
	 */
	function set packageName(value:String):void;
	
	//----------------------------------
	//  typeNode
	//----------------------------------
	
	/**
	 * A reference to the public <code>IType</code> found within the 
	 * <code>IPackage</code>.
	 * 
	 * <p>This type can either be a <code>IClassType</code> or 
	 * <code>IInterfaceType</code>.
	 * 
	 * @see org.teotigraphix.asblocks.api.IClassType
	 * @see org.teotigraphix.asblocks.api.IInterfaceType
	 */
	function get typeNode():IType;
}
}