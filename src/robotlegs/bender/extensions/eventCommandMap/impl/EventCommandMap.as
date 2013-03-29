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
	import robotlegs.bender.framework.api.IContext;

	/**
	 * @private
	 */
	public class EventCommandMap implements IEventCommandMap
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector:Injector;

		private var _dispatcher:IEventDispatcher;

		private var _commandCenter:ICommandCenter;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMap(
			context:IContext,
			dispatcher:IEventDispatcher,
			commandCenter:ICommandCenter)
		{
			_injector = context.injector;
			_dispatcher = dispatcher;
			_commandCenter = commandCenter
				.withTriggerFactory(createTrigger)
				.withKeyFactory(getKey)
				.withLogger(context.getLogger(this));
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(eventType:String, eventClass:Class = null):ICommandMapper
		{
			return createMapper(eventType, eventClass);
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(eventType:String, eventClass:Class = null):ICommandUnmapper
		{
			return createMapper(eventType, eventClass);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function createMapper(eventType:String, eventClass:Class = null):CommandMapper
		{
			const trigger:ICommandTrigger = _commandCenter.getOrCreateNewTrigger(eventType, eventClass);
			return new CommandMapper(trigger);
		}

		private function createTrigger(eventType:String, eventClass:Class = null):ICommandTrigger
		{
			return new EventCommandTrigger(_injector, _dispatcher, eventType, eventClass);
		}

		private function getKey(eventType:String, eventClass:Class = null):Object
		{
			eventClass ||= Event;
			return eventType + eventClass;
		}
	}
}
