package org.as3commons.asblocks.parser.core
{

import org.as3commons.asblocks.parser.api.AS3NodeKind;
import org.as3commons.asblocks.parser.api.KeyWords;
import org.as3commons.asblocks.parser.api.Operators;
import org.as3commons.collections.Map;
import org.as3commons.collections.framework.IMap;

public class AS3ParserMap
{
	public static var additive:IMap;
	
	public static var assignment:IMap;
	
	public static var equality:IMap;
	
	public static var relation:IMap;
	
	public static var shift:IMap;
	
	public static var multiplicative:IMap;
	
	private static var initialized:Boolean = maps();
	
	private static function maps():Boolean
	{
		if (initialized)
			return true;
		
		additive = new Map();
		additive.add(Operators.PLUS, AS3NodeKind.PLUS);
		additive.add(Operators.MINUS, AS3NodeKind.MINUS);
		
		assignment = new Map();
		assignment.add(Operators.ASSIGN, AS3NodeKind.ASSIGN);
		assignment.add(Operators.STAR_ASSIGN, AS3NodeKind.STAR_ASSIGN);
		assignment.add(Operators.DIV_ASSIGN, AS3NodeKind.DIV_ASSIGN);
		assignment.add(Operators.MOD_ASSIGN, AS3NodeKind.MOD_ASSIGN);
		assignment.add(Operators.PLUS_ASSIGN, AS3NodeKind.PLUS_ASSIGN);
		assignment.add(Operators.MINUS_ASSIGN, AS3NodeKind.MINUS_ASSIGN);
		assignment.add(Operators.SL_ASSIGN, AS3NodeKind.SL_ASSIGN);
		assignment.add(Operators.SR_ASSIGN, AS3NodeKind.SR_ASSIGN);
		assignment.add(Operators.BSR_ASSIGN, AS3NodeKind.BSR_ASSIGN);
		assignment.add(Operators.BAND_ASSIGN, AS3NodeKind.BAND_ASSIGN);
		assignment.add(Operators.BXOR_ASSIGN, AS3NodeKind.BXOR_ASSIGN);
		assignment.add(Operators.BOR_ASSIGN, AS3NodeKind.BOR_ASSIGN);
		assignment.add(Operators.LAND_ASSIGN, AS3NodeKind.LAND_ASSIGN);
		assignment.add(Operators.LOR_ASSIGN, AS3NodeKind.LOR_ASSIGN);
		
		equality = new Map();
		equality.add(Operators.EQUAL, AS3NodeKind.EQUAL);
		equality.add(Operators.NOT_EQUAL, AS3NodeKind.NOT_EQUAL);
		equality.add(Operators.STRICT_EQUAL, AS3NodeKind.STRICT_EQUAL);
		equality.add(Operators.STRICT_NOT_EQUAL, AS3NodeKind.STRICT_NOT_EQUAL);
		
		relation = new Map();
		relation.add(KeyWords.IN, AS3NodeKind.IN);
		relation.add(Operators.LT, AS3NodeKind.LT);
		relation.add(Operators.LE, AS3NodeKind.LE);
		relation.add(Operators.GT, AS3NodeKind.GT);
		relation.add(Operators.GE, AS3NodeKind.GE);
		relation.add(KeyWords.IS, AS3NodeKind.IS);
		relation.add(KeyWords.AS, AS3NodeKind.AS);
		relation.add(KeyWords.INSTANCE_OF, AS3NodeKind.INSTANCE_OF);
		
		shift = new Map();
		shift.add(Operators.SL, AS3NodeKind.SL);
		shift.add(Operators.SR, AS3NodeKind.SR);
		shift.add(Operators.SSL, AS3NodeKind.SSL);
		shift.add(Operators.BSR, AS3NodeKind.BSR);
		
		multiplicative = new Map();
		multiplicative.add(Operators.STAR, AS3NodeKind.STAR);
		multiplicative.add(Operators.DIV, AS3NodeKind.DIV);
		multiplicative.add(Operators.MOD, AS3NodeKind.MOD);
		
		return true;
	}
}
}