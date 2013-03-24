//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	/**
	 * @private
	 */
	public class EventCommandMap implements IEventCommandMap
	{

		/*============================================================================*/
		/* Protected Properties                                                       */
		/*============================================================================*/

		protected var _commandCenter:ICommandCenter;

		protected var _strategy : EventCommandMapStrategy;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMap(
			injector:Injector,
			dispatcher:IEventDispatcher,
			commandCenter : ICommandCenter )
		{
			_commandCenter = commandCenter;
			_strategy = new EventCommandMapStrategy( injector, dispatcher, commandCenter );
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(type:String, eventClass:Class = null):ICommandMapper
		{
			return createMapper( type, eventClass );
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(type:String, eventClass:Class = null):ICommandUnmapper
		{
			return createMapper( type, eventClass );
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function createMapper( type : String, eventClass : Class = null):CommandMapper
		{
			var trigger : EventCommandTrigger = _strategy.getTrigger( type, eventClass );
			return new CommandMapper( _commandCenter, trigger );
		}

	}
}
