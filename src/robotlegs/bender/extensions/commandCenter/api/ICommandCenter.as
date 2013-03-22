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
	 * Creates command mappings for triggers
	 */
	public interface ICommandCenter
	{

		/**
		 * TODO: document
		 */
		function get strategy():ICommandMapStrategy;
		function set strategy(value:ICommandMapStrategy):void;

		/**
		 * TODO: document
		 */
		function getMappings( trigger : ICommandTrigger ) : Vector.<ICommandMapping>;

		/**
		 * TODO: document
		 */
		function executeCommand( mapping : ICommandMapping, hooks: ICommandExecutionHooks ) : void;

		/**
		 * TODO: document
		 */
		function executeCommands( mappings : Vector.<ICommandMapping>, hooks : ICommandExecutionHooks ) : void;

		/**
		 * TODO: document
		 */
		function map( trigger : ICommandTrigger, commandClass : Class ) : ICommandMapping;

		/**
		 * TODO: document
		 */
		function unmap( trigger : ICommandTrigger, commandClass : Class ) : void;

		/**
		 * TODO: document
		 */
		function unmapAll( trigger : ICommandTrigger ) : void;

	}
}
