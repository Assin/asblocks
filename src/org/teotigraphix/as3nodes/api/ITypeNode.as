package org.teotigraphix.as3nodes.api
{

public interface ITypeNode extends INode, INameAware, IVisible, IMetaDataAware
{
	function get constants():Vector.<IConstantNode>;
}
}