package testSuites
{

import org.teotigraphix.as3parser.impl.TestAS3Scanner;
import org.teotigraphix.as3parser.impl.TestClass;
import org.teotigraphix.as3parser.impl.TestClassContent;
import org.teotigraphix.as3parser.impl.TestCompilationUnit;
import org.teotigraphix.as3parser.impl.TestConstStatement;
import org.teotigraphix.as3parser.impl.TestDoStatement;
import org.teotigraphix.as3parser.impl.TestEmptyStatement;
import org.teotigraphix.as3parser.impl.TestExpression;
import org.teotigraphix.as3parser.impl.TestForStatement;
import org.teotigraphix.as3parser.impl.TestIfStatement;
import org.teotigraphix.as3parser.impl.TestInterface;
import org.teotigraphix.as3parser.impl.TestInterfaceContent;
import org.teotigraphix.as3parser.impl.TestPackageContent;
import org.teotigraphix.as3parser.impl.TestPrimaryExpression;
import org.teotigraphix.as3parser.impl.TestReturnStatement;
import org.teotigraphix.as3parser.impl.TestSwitchStatement;
import org.teotigraphix.as3parser.impl.TestTryCatchFinallyStatement;
import org.teotigraphix.as3parser.impl.TestUnaryExpression;
import org.teotigraphix.as3parser.impl.TestVarStatement;
import org.teotigraphix.as3parser.impl.TestWhileStatement;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class AS3ParserTestSuite
{
	// TestAS3Parser
	public var testAS3Scanner:TestAS3Scanner;
	public var testClass:TestClass;
	public var testClassContent:TestClassContent;
	public var testCompilationUnit:TestCompilationUnit;
	public var testConstStatement:TestConstStatement;
	public var testDoStatement:TestDoStatement;
	// TestE4xExpression
	public var testEmptyStatement:TestEmptyStatement;
	public var testExpression:TestExpression;
	public var testForStatement:TestForStatement;
	public var testIfStatement:TestIfStatement;
	public var testInterface:TestInterface;
	public var testInterfaceContent:TestInterfaceContent;
	public var testPackageContent:TestPackageContent;
	public var testPrimaryExpression:TestPrimaryExpression;
	public var testReturnStatement:TestReturnStatement;
	public var testSwitchStatement:TestSwitchStatement;
	public var testTryCatchFinallyStatement:TestTryCatchFinallyStatement;
	public var testUnaryExpression:TestUnaryExpression;
	public var testVarStatement:TestVarStatement;
	public var testWhileStatement:TestWhileStatement;
}
}