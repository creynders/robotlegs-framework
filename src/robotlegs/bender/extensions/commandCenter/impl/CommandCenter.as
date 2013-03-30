//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.framework.api.IContext;

	public class CommandCenter implements ICommandCenter
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _context:IContext;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function CommandCenter(context:IContext)
		{
			_context = context;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function execute(commandClass:Class):void
		{
			const command:Object = _context.injector.instantiateUnmapped(commandClass);
			"execute" in command && command.execute();
		}

		/**
		 * @inheritDoc
		 */
		public function detain(command:Object):void
		{
			_context.detain(command);
		}

		/**
		 * @inheritDoc
		 */
		public function release(command:Object):void
		{
			_context.release(command);
		}
	}
}
