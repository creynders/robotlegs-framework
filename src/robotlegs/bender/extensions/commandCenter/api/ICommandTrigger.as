//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * Represents a command trigger
	 */
	public interface ICommandTrigger
	{

		/**
		 * @private
		 */
		function withLogger(logger:ILogger):void;

		/**
		 * TODO: document
		 */
		function map(commandClass:Class):ICommandMapping;

		/**
		 * TODO: document
		 */
		function unmap(commandClass:Class):void;

		/**
		 * TODO: document
		 */
		function unmapAll():void;

		/**
		 * TODO: document
		 */
		function getMappings():Vector.<ICommandMapping>;

		/**
		 * TODO: document and rename [!]
		 */
		function activate():void;

		/**
		 * TODO: document and rename [!]
		 */
		function deactivate():void;
	}
}
