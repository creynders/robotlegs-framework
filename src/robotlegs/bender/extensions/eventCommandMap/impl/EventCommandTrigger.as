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
	public class EventCommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _type:String;

		/**
		 * TODO: document
		 */
		public function get type():String
		{
			return _type;
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

		private var _decorated:CommandTrigger;

		private var _dispatcher : IEventDispatcher;

		private var _injector : Injector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandTrigger(
			injector : Injector,
			dispatcher : IEventDispatcher,
			type:String,
			eventClass:Class,
			decorated : ICommandTrigger = null)
		{
			_injector = injector.createChildInjector();
			_dispatcher = dispatcher;
			_type = type;
			_eventClass = eventClass;
			_decorated = new CommandTrigger( decorated || this );
		}


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function activate():void
		{
			_dispatcher.addEventListener( type, handleEvent );
		}

		public function deactivate():void
		{
			_dispatcher.removeEventListener( type, handleEvent );
		}


		/**
		 * @inheritDoc
		 */
		public function getMappings():Vector.<ICommandMapping>
		{
			return _decorated.getMappings();
		}

		/**
		 * @inheritDoc
		 */
		public function map(commandClass:Class):ICommandMapping
		{
			return _decorated.map(commandClass);
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(commandClass:Class):void
		{
			_decorated.unmap(commandClass);
		}

		/**
		 * @inheritDoc
		 */
		public function unmapAll():void
		{
			_decorated.unmapAll();
		}

		public function createMapping(commandClass:Class):ICommandMapping
		{
			return _decorated.createMapping( commandClass );
		}


		public function toString():String
		{
			return _eventClass + " with selector '" + _type + "'";
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		protected function handleEvent(event:Event):void
		{
			const eventConstructor:Class = event["constructor"] as Class;
			if ( _eventClass && _eventClass != eventConstructor)
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
				.withCommandClassUnmapper( unmap );
			executor.executeCommands(getMappings().concat());
		}

	}
}

