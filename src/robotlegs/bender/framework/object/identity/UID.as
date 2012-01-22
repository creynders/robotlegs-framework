//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.framework.object.identity
{
	import avmplus.getQualifiedClassName;

	public class UID
	{

		/*============================================================================*/
		/* Private Static Properties                                                  */
		/*============================================================================*/

		private static var i:uint;

		/*============================================================================*/
		/* Public Static Functions                                                    */
		/*============================================================================*/

		public static function create(source:* = null):String
		{
			if (source is Class)
				source = getQualifiedClassName(source).split("::").pop();
			return (source ? source + '-' : '')
				+ (i++).toString(16)
				+ '-'
				+ (Math.random() * 255).toString(16);
		}
	}
}
