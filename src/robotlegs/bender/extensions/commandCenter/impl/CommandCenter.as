//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import flash.utils.Dictionary;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @private
	 */
	public class CommandCenter implements ICommandCenter
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _logger:ILogger;

		/**
		 * @private
		 */
		public function set logger(value:ILogger):void
		{
			_logger = value;
		}

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
		public function map(trigger:ICommandTrigger, key : *):void
		{
            _triggersByKey[ key ] = trigger;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(key:*):void
		{
			delete _triggersByKey[ key ];
		}
        
        public function getTrigger(key:*):ICommandTrigger
        {
            return _triggersByKey[ key ];
        }
        
    }
}
