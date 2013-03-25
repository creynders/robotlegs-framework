//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;

	/**
	 * Executes triggers and commands
	 */
	public interface ICommandExecutor
	{

		function withPayloadMapper(mapPayload:Function):ICommandExecutor;

		function withPayloadUnmapper(unmapPayload:Function):ICommandExecutor;

		/**
		 * TODO: document
		 */
		function executeCommands(mappings:Vector.<ICommandMapping>):void;

	}
}
