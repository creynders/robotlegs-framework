//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;

	/**
	 * Represents a command mapping
	 */
	public interface ICommandMapping
	{
		/**
		 * The concrete Command Class for this mapping
		 */
		function get commandClass():Class;

		/**
		 * A list of Guards to query before execution
		 */
		function get guards():Array;

		/**
		 * A list of Hooks to run during execution
		 */
		function get hooks():Array;

		/**
		 * Unmaps a Command after a successful execution
		 */
		function get fireOnce():Boolean;
        
        function setCommandClass( commandClass : Class )  :ICommandMapping;
        
        function addGuards( ...guards ) : ICommandMapping;
        
        function addHooks( ...hooks ) : ICommandMapping;
        
        function setFireOnce( value : Boolean ) : ICommandMapping;

	}
}
