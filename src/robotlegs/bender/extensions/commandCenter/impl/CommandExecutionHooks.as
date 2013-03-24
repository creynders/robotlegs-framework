//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutionHooks;

	/**
	 * @private
	 */
	public class CommandExecutionHooks implements ICommandExecutionHooks
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _mapPayload:Function;

		/**
		 * @inheritDoc
		 */
		public function get mapPayload():Function
		{
			return _mapPayload;
		}

		/**
		 * @inheritDoc
		 */
		public function set mapPayload(value:Function):void
		{
			_mapPayload = value;
		}

		private var _unmapPayload:Function;

		/**
		 * @inheritDoc
		 */
		public function get unmapPayload():Function
		{
			return _unmapPayload;
		}

		/**
		 * @inheritDoc
		 */
		public function set unmapPayload(value:Function):void
		{
			_unmapPayload = value;
		}

		private var _whenCommandExecuted:Function;

		/**
		 * @inheritDoc
		 */
		public function get whenCommandExecuted():Function
		{
			return _whenCommandExecuted;
		}

		/**
		 * @inheritDoc
		 */
		public function set whenCommandExecuted(value:Function):void
		{
			_whenCommandExecuted = value;
		}
	}
}
