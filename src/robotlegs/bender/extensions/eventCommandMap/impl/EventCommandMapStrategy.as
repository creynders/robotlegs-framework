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
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutionHooks;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandExecutionHooks;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;

	/**
	 * @private
	 */
	public class EventCommandMapStrategy implements ICommandMapStrategy
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector:Injector;

		private var _dispatcher:IEventDispatcher;

		private var _commandMap:ICommandCenter;

		//TODO: const
		private var _triggers:Dictionary = new Dictionary(false);

		//TODO: const
		private var _handlers:Dictionary = new Dictionary(false);

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMapStrategy(
			injector:Injector,
			dispatcher:IEventDispatcher,
			commandMap:ICommandCenter)
		{
			_injector = injector;
			_dispatcher = dispatcher;
			_commandMap = commandMap;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * TODO: decide whether this should be declared in a IEventCommandMapStrategy
		 * & document
		 */
		public function getTrigger(eventType:String, eventClass:Class = null):EventCommandTrigger
		{
			var trigger:ICommandTrigger = _triggers[eventType + eventClass];
			if (!trigger)
			{
				trigger = createTrigger(eventType, eventClass);
			}
			return trigger as EventCommandTrigger;
		}

		/**
		 * @inheritDoc
		 */
		public function registerTrigger(trigger:ICommandTrigger):void
		{
			var eventTrigger:EventCommandTrigger = trigger as EventCommandTrigger;
			var handler:Function = function(event:Event):void {
				handleEvent(eventTrigger, event);
			}
			_handlers[eventTrigger] = handler;
			_dispatcher.addEventListener(eventTrigger.type, handler);
		}

		/**
		 * @inheritDoc
		 */
		public function unregisterTrigger(trigger:ICommandTrigger):void
		{
			var eventTrigger:EventCommandTrigger = trigger as EventCommandTrigger;
			var handler:Function = _handlers[eventTrigger];
			delete _handlers[eventTrigger];
			_dispatcher.removeEventListener(eventTrigger.type, handler);
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function handleEvent(trigger:EventCommandTrigger, event:Event):void
		{

			var eventConstructor:Class = event["constructor"] as Class;
			if (trigger.eventClass != Event && trigger.eventClass != eventConstructor)
			{
				return;
			}
			var hooks:ICommandExecutionHooks = new CommandExecutionHooks();

			hooks.mapPayload = function():void {
				_injector.map(Event).toValue(event);
				if (eventConstructor != Event)
				{
					_injector.map(eventConstructor).toValue(event);
				}
			}

			hooks.unmapPayload = function():void {
				_injector.unmap(Event);
				if (eventConstructor != Event)
				{
					_injector.unmap(eventConstructor);
				}
			}
			_commandMap.executeTrigger(trigger, hooks);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function createTrigger(eventType:String, eventClass:Class):ICommandTrigger
		{
			eventClass ||= Event;
			var trigger:ICommandTrigger = new EventCommandTrigger(this, eventType, eventClass);
			_triggers[eventType + eventClass] = trigger;
			return trigger;
		}
	}
}
