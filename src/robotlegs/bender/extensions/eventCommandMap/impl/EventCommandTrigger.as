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
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.impl.CommandExecutor;
	import robotlegs.bender.extensions.commandCenter.impl.CommandTrigger;

	/**
	 * @private
	 */
	public class EventCommandTrigger extends CommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _eventType:String;

		/**
		 * TODO: document
		 */
		public function get eventType():String
		{
			return _eventType;
		}

		private var _eventClass:Class;

		/**
		 * TODO: document
		 */
		public function get eventClass():Class
		{
			return _eventClass;
		}

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _dispatcher:IEventDispatcher;

		private var _injector:Injector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandTrigger(
			injector:Injector,
			dispatcher:IEventDispatcher,
			eventType:String,
			eventClass:Class)
		{
			_injector = injector.createChildInjector();
			_dispatcher = dispatcher;
			_eventType = eventType;
			_eventClass = eventClass;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		override public function activate():void
		{
			_dispatcher.addEventListener(eventType, handleEvent);
		}

		override public function deactivate():void
		{
			_dispatcher.removeEventListener(eventType, handleEvent);
		}

		public function toString():String
		{
			return _eventClass + " with selector '" + _eventType + "'";
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		protected function handleEvent(event:Event):void
		{
			const eventConstructor:Class = event["constructor"] as Class;
			if (_eventClass && _eventClass != eventConstructor)
			{
				return;
			}
			const executor:ICommandExecutor = new CommandExecutor(_injector)
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
				})
				.withCommandClassUnmapper(unmap);
			executor.executeCommands(getMappings().concat());
		}
	}
}

