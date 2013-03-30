//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{
	public interface ICommandCenter
	{
		/**
		 * TODO: document
		 */
		function execute(commandClass:Class):void;

		/**
		 * TODO: document
		 */
		function detain(command:Object):void;

		/**
		 * TODO: document
		 */
		function release(command:Object):void;
	}
}
