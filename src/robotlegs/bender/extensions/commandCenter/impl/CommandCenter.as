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
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _triggersByKey:Dictionary = new Dictionary(false);

		private var _triggerFactory:Function;

		private var _keyFactory:Function;

		private var _logger:ILogger;

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function withTriggerFactory(triggerFactory:Function):ICommandCenter
		{
			_triggerFactory = triggerFactory;
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function withKeyFactory(keyFactory:Function):ICommandCenter
		{
			_keyFactory = keyFactory;
			return this;
		}

		public function withLogger(logger:ILogger):ICommandCenter
		{
			_logger = logger;
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeTrigger(... key):void
		{
			delete _triggersByKey[serializeKey(key)];
		}

		/**
		 * @inheritDoc
		 */
		public function getOrCreateNewTrigger(... key):ICommandTrigger
		{
			var serializedKey:Object = serializeKey(key)
			var trigger:ICommandTrigger = _triggersByKey[serializedKey];
			if (!trigger)
			{
				trigger = _triggerFactory.apply(null, key);
				_logger && trigger.withLogger(_logger);
				_triggersByKey[serializedKey] = trigger;
			}
			return trigger;
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function serializeKey(args:Array):Object
		{
			return _keyFactory.apply(null, args);
		}
	}
}
