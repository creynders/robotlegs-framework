//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import flash.utils.Dictionary;
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @private
	 */
	public class CommandCenter implements ICommandCenter
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _triggersByKey:Dictionary = new Dictionary();

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(trigger:ICommandTrigger, key:*):void
		{
			//TODO: determine what to do if already exists
			_triggersByKey[key] = trigger;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(key:*):void
		{
			//TOOD: determine what to do when not found
			delete _triggersByKey[key];
		}

		/**
		 * @inheritDoc
		 */
		public function getTrigger(key:*):ICommandTrigger
		{
			return _triggersByKey[key];
		}
	}
}
