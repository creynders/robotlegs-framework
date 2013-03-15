//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl{

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	/**
	 * TODO: document
	 */
	public function executeCommand( command : Object ) : void{
		"execute" in command && command.execute();
	}
}