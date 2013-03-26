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

		private var _triggersByKey:Dictionary = new Dictionary( false );

		private var _callbackByTrigger : Dictionary = new Dictionary();

		private var _triggerFactory : Function;

		private var _keyFactory:Function;

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function withTriggerFactory(triggerFactory:Function):ICommandCenter
		{
			_triggerFactory = triggerFactory;
			return this;
		}

		public function withKeyFactory( keyFactory : Function ) : ICommandCenter{
			_keyFactory = keyFactory;
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function createCallback( trigger : ICommandTrigger, handler : Function ) : Function{
			var callback : Function = function( ...args ) : void{
				var p : Array = [ trigger ].concat( args );
				handler.apply( null, p );
			}
			_callbackByTrigger[ trigger ] = callback;
			return callback;
		}

		/**
		 * @inheritDoc
		 */
		public function removeCallback( trigger : ICommandTrigger ) : Function{
			var callback : Function = _callbackByTrigger[ trigger ];
			delete _callbackByTrigger[ trigger ];
			return callback;
		}

		/**
		 * @inheritDoc
		 */
		public function unmapTriggerFromKey( ...key ):void
		{
			delete _triggersByKey[createKey( key )];
		}

		/**
		 * @inheritDoc
		 */
		public function getTriggerByKey( ...key ):ICommandTrigger
		{
			var trigger : ICommandTrigger = _triggersByKey[createKey( key )];
			if( ! trigger ){
				trigger = _triggerFactory.apply( null, key );
				mapTriggerToKey( trigger, key );
			}
			return trigger;
		}

		private function mapTriggerToKey(trigger:ICommandTrigger, key : Array ):void
		{
			_triggersByKey[createKey( key )] = trigger;
		}

		private function createKey( args : Array ) : Object{
			return _keyFactory.apply( null, args );
		}
	}
}
