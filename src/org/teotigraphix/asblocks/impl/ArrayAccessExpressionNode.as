package org.teotigraphix.asblocks.impl
{

import org.teotigraphix.asblocks.api.IArrayAccessExpressionNode;
import org.teotigraphix.asblocks.api.IExpressionNode;
import org.teotigraphix.as3parser.api.IParserNode;

/**
 * The <code>IArrayAccessExpressionNode</code> implementation.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class ArrayAccessExpressionNode extends ExpressionNode 
	implements IArrayAccessExpressionNode
{
	//--------------------------------------------------------------------------
	//
	//  IArrayAccessExpressionNode API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  target
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IArrayAccessExpressionNode#target
	 */
	public function get target():IExpressionNode
	{
		return ExpressionBuilder.build(node.getFirstChild());
	}
	
	/**
	 * @private
	 */	
	public function set target(value:IExpressionNode):void
	{
		node.setChildAt(value.node, 0);
	}
	
	//----------------------------------
	//  subscript
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.asblocks.api.IArrayAccessExpressionNode#subscript
	 */
	public function get subscript():IExpressionNode
	{
		return ExpressionBuilder.build(node.getLastChild());
	}
	
	/**
	 * @private
	 */	
	public function set subscript(value:IExpressionNode):void
	{
		node.setChildAt(value.node, 1);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ArrayAccessExpressionNode(node:IParserNode)
	{
		super(node);
	}
}
}