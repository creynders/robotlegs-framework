//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{

	/**
	 * TODO: document
	 */
	public interface ICommandExecutionHooks
	{

		/**
		 * TODO: document
		 */
		function set mapPayload(value:Function):void;
		function get mapPayload():Function;

		/**
		 * TODO: document
		 */
		function set unmapPayload(value:Function):void;
		function get unmapPayload():Function;

		/**
		 * TODO: document
		 */
		function set whenCommandExecuted(value:Function):void;
		function get whenCommandExecuted():Function;
	}
}
