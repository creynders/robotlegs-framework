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

		function get strategy():ICommandMapStrategy;
		function set strategy(value:ICommandMapStrategy):void;

		function getMappings( trigger : * ) : Vector.<ICommandMapping>;
		function executeCommands( mappings : Vector.<ICommandMapping>, hooks : ICommandExecutionHooks ) : void;

		function map( mapping:ICommandMapping ) : void;
		function unmap( mapping:ICommandMapping ) : void;
		function unmapAll( trigger : * ) : void;

	}
}
