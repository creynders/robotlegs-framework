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
	public class EventCommandMapStrategy implements ICommandMapStrategy{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector : Injector;

		private var _dispatcher : IEventDispatcher;

		private var _commandMap : ICommandCenter;

		private var _triggers : Dictionary = new Dictionary( false );

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMapStrategy(injector : Injector, dispatcher : IEventDispatcher, commandMap : ICommandCenter)
		{
			_injector = injector;
			_dispatcher = dispatcher;
			_commandMap = commandMap;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		public function getTrigger( eventType : String, eventClass : Class = null ) : EventCommandTrigger{

			var trigger : ICommandTrigger = getTriggerFromMap( eventType, eventClass );
			if( !trigger ){
				trigger = createTrigger( eventType, eventClass );
			}
			return trigger as EventCommandTrigger;
		}

		private function createTrigger(eventType:String, eventClass:Class):ICommandTrigger
		{
			eventClass ||= Event;
			var trigger : ICommandTrigger = new EventCommandTrigger( this, eventType, eventClass );
			_triggers[ eventType + eventClass ] = trigger;
			return trigger;
		}

		/**
		 * @inheritDoc
		 */
		public function registerTrigger(trigger:ICommandTrigger):void
		{
			var eventTrigger : EventCommandTrigger = trigger as EventCommandTrigger;
			_dispatcher.addEventListener( eventTrigger.type, handleEvent );
		}

		/**
		 * @inheritDoc
		 */
		public function unregisterTrigger(trigger:ICommandTrigger):void
		{
			var eventTrigger : EventCommandTrigger = trigger as EventCommandTrigger;
			_dispatcher.removeEventListener( eventTrigger.type, handleEvent );
		}

		/**
		 * TODO: document
		 */
		public function createMapping( trigger : ICommandTrigger, commandClass : Class ):ICommandMapping
		{
			return new CommandMapping( trigger, commandClass );
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function handleEvent( event : Event ) : void{

			var eventConstructor : Class = event["constructor"] as Class;
			var mappings : Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

			var trigger : ICommandTrigger;
			trigger = getTriggerFromMap(event.type, eventConstructor);
			trigger && ( mappings = mappings.concat( trigger.getMappings() ) );

			trigger = getTriggerFromMap( event.type );
			trigger && ( mappings = mappings.concat( trigger.getMappings() ) );

			if( mappings.length <= 0 ){
				return;
			}

			var hooks : ICommandExecutionHooks = new CommandExecutionHooks();

			hooks.mapPayload = function() : void{
				_injector.map(Event).toValue(event);
				if (eventConstructor != Event)
				{
					_injector.map( eventConstructor ).toValue(event);
				}
			}

			hooks.unmapPayload = function() : void{
				_injector.unmap(Event);
				if (eventConstructor != Event)
				{
					_injector.unmap( eventConstructor );
				}
			}
			_commandMap.executeCommands( mappings, hooks );
		}

		private function getTriggerFromMap(eventType:String, eventClass:Class=null):ICommandTrigger
		{
			eventClass ||= Event;
			return _triggers[ eventType + eventClass ];
		}

	}
}