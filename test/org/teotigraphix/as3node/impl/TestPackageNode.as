package org.teotigraphix.as3node.impl
{

import org.flexunit.Assert;
import org.teotigraphix.as3nodes.api.IMetaDataNode;
import org.teotigraphix.as3nodes.api.IPackageNode;
import org.teotigraphix.as3nodes.api.Modifier;
import org.teotigraphix.as3nodes.impl.PackageNode;
import org.teotigraphix.as3nodes.impl.TypeNode;
import org.teotigraphix.as3parser.api.IParserNode;
import org.teotigraphix.as3parser.impl.AS3Parser;
import org.teotigraphix.as3parser.utils.ASTUtil;

public class TestPackageNode
{
	private var unit:IParserNode;
	
	private var parser:AS3Parser;
	
	[Before]
	public function setUp():void
	{
		parser = new AS3Parser();
		
		var lines:Array =
			[
				"package my.domain {",
				"    import flash.events.IEventDispatcher",
				"    [Bindable]",
				"    [Factory(type=\"my.factory.Class\")]",
				"    /** Class comment. */",
				"    public final class Test extends OtherTest implements IEventDispatcher",
				"    {",
				"        public static const NAME:String = \"smile\";",
				"        [Inject(source=\"model.dataProvider\")]",
				"        public var variable:String = \"variable\";",
				"        public function get property():String{return null;}",
				"        public function set property(value:String):void{}",
				"        [Test]",
				"        public function method():void",
				"        {",
				"        }",
				"    }",
				"}",
			];
		
		unit = parser.buildAst(ASTUtil.toVector(lines), "internal");
	}
	
	[Test]
	public function testPackageNode():void
	{
		var packageNode:PackageNode = new PackageNode(unit, null);
		
		Assert.assertNotNull(packageNode.node);
		Assert.assertEquals("my.domain", packageNode.name);
		Assert.assertEquals("my.domain.Test", packageNode.qualifiedName);
		Assert.assertNotNull(packageNode.typeNode);
		Assert.assertNotNull(packageNode.imports);
	}
	
	[Test]
	public function testTypeNode():void
	{
		var packageNode:PackageNode = new PackageNode(unit, null);
		var typeNode:TypeNode = packageNode.typeNode as TypeNode;
		Assert.assertNotNull(typeNode);
		Assert.assertStrictlyEquals(packageNode, typeNode.parent);
		
		// modifiers
		Assert.assertTrue(typeNode.hasModifier(Modifier.PUBLIC));
		Assert.assertTrue(typeNode.hasModifier(Modifier.FINAL));
		Assert.assertFalse(typeNode.hasModifier(Modifier.DYNAMIC));
		
		Assert.assertTrue(typeNode.isPublic);
		Assert.assertTrue(typeNode.isFinal);
		Assert.assertTrue(typeNode.isBindable);
		
		// metadata
		var meta:Vector.<IMetaDataNode>;
		Assert.assertEquals(2, typeNode.numMetaData);
		meta = typeNode.getMetaData("Bindable");
		Assert.assertStrictlyEquals(typeNode, meta[0].parent);
		Assert.assertNotNull(meta);
		Assert.assertEquals("Bindable", meta[0].name);
		Assert.assertEquals("", meta[0].parameter);
		
		meta = typeNode.getMetaData("Factory");
		Assert.assertStrictlyEquals(typeNode, meta[0].parent);
		Assert.assertNotNull(meta);
		Assert.assertEquals("Factory", meta[0].name);
		Assert.assertEquals("type = \"my.factory.Class\"", meta[0].parameter);
		
		// name
		Assert.assertEquals("Test", typeNode.name);
		Assert.assertEquals("my.domain", IPackageNode(typeNode.parent).name);
		Assert.assertEquals("my.domain.Test", IPackageNode(typeNode.parent).qualifiedName);
		
		
	}
}
}