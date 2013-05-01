//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.directCommandMap.dsl
{
	import robotlegs.bender.extensions.commandCenter.api.CommandPayload;

	public interface IDirectCommandMapper
	{

		/**
		 * Creates a mapping for a command class
		 * @param commandClass The concrete Command class
		 * @return Mapping configurator
		 */
		function map(commandClass:Class):IDirectCommandConfigurator;

		/**
		 * Execute the configured command(s)
		 * @param payload The Command Payload
		 */
		function execute(payload:CommandPayload = null):void;
	}
}
