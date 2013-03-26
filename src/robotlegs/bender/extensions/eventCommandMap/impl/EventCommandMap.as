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

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandCenter;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	/**
	 * @private
	 */
	public class EventCommandMap implements IEventCommandMap
	{

		/*============================================================================*/
		/* Protected Properties                                                       */
		/*============================================================================*/

		protected var _injector : Injector;

		protected var _dispatcher : IEventDispatcher;

		protected var _commandCenter : ICommandCenter;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMap(
			injector:Injector,
			dispatcher:IEventDispatcher)
		{
			_injector = injector;
			_dispatcher = dispatcher;
			_commandCenter = new CommandCenter()
				.withTriggerFactory(createTrigger)
				.withKeyFactory(getKey);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(type:String, eventClass:Class = null):ICommandMapper
		{
			return createMapper(type, eventClass);
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(type:String, eventClass:Class = null):ICommandUnmapper
		{
			return createMapper(type, eventClass);
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		protected function getTrigger(eventType:String, eventClass:Class = null):ICommandTrigger
		{
			return _commandCenter.getOrCreateNewTrigger(eventType, eventClass);
		}

		/**
		 * TODO: document
		 */
		protected function createMapper(type:String, eventClass:Class = null):CommandMapper
		{
			const trigger:ICommandTrigger = getTrigger(type, eventClass);
			return new CommandMapper(trigger);
		}

		protected function createTrigger(eventType:String, eventClass:Class = null):ICommandTrigger
		{
			return new EventCommandTrigger(_injector, _dispatcher, eventType, eventClass);
		}

		protected function getKey(eventType:String, eventClass:Class = null):Object
		{
			eventClass ||= Event;
			return eventType + eventClass;
		}
	}
}
