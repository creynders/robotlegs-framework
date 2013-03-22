//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{

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

		/**
		 * TODO: document
		 */
		function get trigger() : *;

		/**
		 * TODO: document
		 */
		function setCommandClass(commandClass:Class):ICommandMapping;

		/**
		 * TODO: document
		 */
		function setTrigger( trigger : * ) : void;

		/**
		 * TODO: document
		 */
		function addGuards(... guards):ICommandMapping;

		/**
		 * TODO: document
		 */
		function addHooks(... hooks):ICommandMapping;

		/**
		 * TODO: document
		 */
		function setFireOnce(value:Boolean):ICommandMapping;

		/**
		 * TODO: document
		 */
		function equals( mapping : ICommandMapping ) : Boolean;
	}
}
