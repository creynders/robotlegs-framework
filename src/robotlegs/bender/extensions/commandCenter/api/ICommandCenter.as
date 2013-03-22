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
		function getMappings( trigger : * ) : Vector.<ICommandMapping>;

		/**
		 * TODO: document
		 */
		function executeCommands( mappings : Vector.<ICommandMapping>, hooks : ICommandExecutionHooks ) : void;

		/**
		 * TODO: document
		 */
		function map( mapping:ICommandMapping ) : void;

		/**
		 * TODO: document
		 */
		function unmap( mapping:ICommandMapping ) : void;

		/**
		 * TODO: document
		 */
		function unmapAll( trigger : * ) : void;

	}
}
