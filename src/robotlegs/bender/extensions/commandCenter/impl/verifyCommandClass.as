//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

// ActionScript file

package robotlegs.bender.extensions.commandCenter.impl
{
	import flash.utils.describeType;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function verifyCommandClass(commandClass:Class):void
	{
		if (describeType(commandClass).factory.method.(@name == "execute").length() == 0)
			throw new Error("Command Class must expose an execute method");
	}
}
