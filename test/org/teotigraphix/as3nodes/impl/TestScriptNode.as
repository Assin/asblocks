package org.teotigraphix.as3nodes.impl
{

import flexunit.framework.Assert;

import org.teotigraphix.as3nodes.api.IMetaDataNode;
import org.teotigraphix.as3nodes.api.IParameterNode;
import org.teotigraphix.as3nodes.api.MetaData;
import org.teotigraphix.as3nodes.api.Modifier;
import org.teotigraphix.as3parser.api.AS3NodeKind;
import org.teotigraphix.as3parser.api.IParserNode;
import org.teotigraphix.as3parser.core.Node;
import org.teotigraphix.as3parser.utils.ASTUtil;

public class TestScriptNode
{
	[Before]
	public function setUp():void
	{
	}
	
	[Test]
	public function test_isBindable():void
	{
		var ast:IParserNode = Node.create("content", -1, -1, null);
		var element:ScriptNode = new ScriptNode(ast, null);
		
		Assert.assertFalse(element.isBindable);
		// new adds the metadata to the node
		// do not need to call addMetaData()
		var bindable:MetaData = MetaData.create("Bindable");
		var metaData:IMetaDataNode = element.newMetaData(bindable.name);
		
		Assert.assertTrue(element.isBindable);
		Assert.assertTrue(element.hasMetaData(bindable.name));
		
		// test AST was added
		var metaList:IParserNode = ASTUtil.getNode(AS3NodeKind.META_LIST, element.node);
		Assert.assertNotNull(metaList);
		Assert.assertEquals(1, metaList.numChildren);
		var meta:IParserNode = metaList.getChild(0);
		Assert.assertNotNull(meta);
		Assert.assertEquals("Bindable", ASTUtil.getNode(AS3NodeKind.NAME, meta).stringValue);
		
		element.removeMetaData(metaData);
		
		// Test AST was removed
		metaList = ASTUtil.getNode(AS3NodeKind.META_LIST, element.node);
		// even though meta-list children is 0, we do not remove the meta-list node
		Assert.assertNotNull(metaList);
		Assert.assertEquals(0, metaList.numChildren);
		
		Assert.assertFalse(element.isBindable);
		Assert.assertFalse(element.hasMetaData(bindable.name));
	}
	
	[Test]
	public function test_description():void
	{
		var ast:IParserNode = Node.create("content", -1, -1, null);
		var element:ScriptNode = new ScriptNode(ast, null);
		Assert.assertNotNull(element.comment);
		
		// setting description will create new new comment with parsed AST
		element.description = "My comment.\n <p>Long desc.</p>";
		
		Assert.assertEquals("My comment.\n <p>Long desc.</p>", element.description);
		Assert.assertNotNull(element.comment);
		
		// usually when an as-doc node is parsed by the as3parser, the as-doc node
		// will have it's stringValue in the form of "/** A comment. */"
		// When the description is set, the as-doc node will have it's first child
		// and ASDocNodeKind.COMPILATION_UNIT
		// as-doc
		var asdoc:IParserNode = ASTUtil.getNode(AS3NodeKind.AS_DOC, element.node);
		Assert.assertNotNull(asdoc);
		// as-doc/compilation-unit
		var compUnit:IParserNode = asdoc.getChild(0);
		Assert.assertNotNull(compUnit);
		// as-doc/compilation-unit/content
		var content:IParserNode = compUnit.getChild(0);
		Assert.assertNotNull(content);
		Assert.assertEquals(2, content.numChildren);
		// as-doc/compilation-unit/short-list
		var short:IParserNode = content.getChild(0);
		// as-doc/compilation-unit/long-list
		var long:IParserNode = content.getChild(1);
		Assert.assertNotNull(short);
		Assert.assertNotNull(long);
		Assert.assertEquals("My comment.", short.getChild(0).stringValue);
		Assert.assertEquals("<p>Long desc.</p>", long.getChild(0).stringValue);
		// now remove the description which removes the as-doc node from
		// the comment node
//		element.description = null;
		//asdoc = ASTUtil.getNode(AS3NodeKind.AS_DOC, element.node);
		//Assert.assertNull(asdoc);
	}
	
	[Test]
	public function test_addRemoveHasMetaData():void
	{
		
	}
	
	[Test]
	public function test_addRemoveHasModifier():void
	{
		var ast:IParserNode = Node.create("content", -1, -1, null);
		var node:ScriptNode = new ScriptNode(ast, null);
		
		Assert.assertEquals(0, node.modifiers.length);
		Assert.assertFalse(node.isPublic);
		Assert.assertFalse(node.hasModifier(Modifier.PUBLIC));
		
		node.addModifier(Modifier.PUBLIC);
		
		Assert.assertEquals(1, node.modifiers.length);
		Assert.assertEquals(1, ast.getChild(0).numChildren);
		Assert.assertEquals(Modifier.PUBLIC.name, ast.getChild(0).getChild(0).stringValue);
		Assert.assertTrue(node.isPublic);
		Assert.assertTrue(node.hasModifier(Modifier.PUBLIC));
		
		node.removeModifier(Modifier.PUBLIC);
		
		Assert.assertEquals(0, node.modifiers.length);
		Assert.assertTrue(ast.getChild(0).isKind(AS3NodeKind.MOD_LIST));
		Assert.assertEquals(0, ast.getChild(0).numChildren);
		Assert.assertFalse(node.isPublic);
		Assert.assertFalse(node.hasModifier(Modifier.PUBLIC));
	}
}
}