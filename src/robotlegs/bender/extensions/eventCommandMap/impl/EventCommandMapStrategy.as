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
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.impl.CommandCenter;
	import robotlegs.bender.extensions.commandCenter.impl.CommandExecutor;

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

		private var _commandCenter:ICommandCenter;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMapStrategy(
			injector:Injector,
			dispatcher:IEventDispatcher)
		{
			_injector = injector.createChildInjector();
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
		public function activate(trigger:ICommandTrigger):void
		{
			var eventTrigger:EventCommandTrigger = trigger as EventCommandTrigger;
			var callback:Function = _commandCenter.createCallback(eventTrigger, handleEvent);
			_dispatcher.addEventListener(eventTrigger.type, callback);
		}

		/**
		 * @inheritDoc
		 */
		public function deactivate(trigger:ICommandTrigger):void
		{
			var eventTrigger:EventCommandTrigger = trigger as EventCommandTrigger;
			var callback:Function = _commandCenter.removeCallback(eventTrigger);
			_dispatcher.removeEventListener(eventTrigger.type, callback);
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function handleEvent(trigger:ICommandTrigger, event:Event):void
		{
			var eventTrigger:EventCommandTrigger = trigger as EventCommandTrigger;
			var eventConstructor:Class = event["constructor"] as Class;
			if (eventTrigger.eventClass && eventTrigger.eventClass != eventConstructor)
			{
				return;
			}
			var executor:ICommandExecutor = new CommandExecutor(_injector, eventTrigger)
				.withPayloadMapper(function():void {
					_injector.map(Event).toValue(event);
					if (eventConstructor != Event)
					{
						_injector.map(eventConstructor).toValue(event);
					}
				})
				.withPayloadUnmapper(function():void {
					_injector.unmap(Event);
					if (eventConstructor != Event)
					{
						_injector.unmap(eventConstructor);
					}
				});
			executor.executeCommands(trigger.getMappings().concat());
		}

		/*============================================================================*/
		/* Internal Functions                                                         */
		/*============================================================================*/

		/**
		 * TODO: decide whether this should be declared in a IEventCommandMapStrategy
		 * & document
		 */
		internal function getTrigger(eventType:String, eventClass:Class = null):ICommandTrigger
		{
			return _commandCenter.getTriggerByKey(eventType, eventClass);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function createTrigger(eventType:String, eventClass:Class = null):ICommandTrigger
		{
			return new EventCommandTrigger(this, eventType, eventClass);
		}

		private function getKey(eventType:String, eventClass:Class = null):Object
		{
			eventClass ||= Event;
			return eventType + eventClass;
		}
	}
}
