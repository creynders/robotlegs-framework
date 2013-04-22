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
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingList;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.api.IExecuteMethodConfigurator;
	import robotlegs.bender.extensions.commandCenter.impl.CommandExecutor;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingList;
	import robotlegs.bender.extensions.commandCenter.impl.CommandPayload;
	import robotlegs.bender.extensions.commandCenter.impl.PayloadCollector;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @private
	 */
	public class EventCommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _dispatcher:IEventDispatcher;

		private var _type:String;

		private var _eventClass:Class;

		private var _mappings:ICommandMappingList;

		private var _executor:ICommandExecutor;

		private var _payloadCollector:PayloadCollector;

		private var _executeMethodConfigurator:IExecuteMethodConfigurator;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandTrigger(
			injector:Injector,
			dispatcher:IEventDispatcher,
			executeMethodMap:IExecuteMethodConfigurator,
			type:String,
			eventClass:Class = null,
			logger:ILogger = null)
		{
			_dispatcher = dispatcher;
			_executeMethodConfigurator = executeMethodMap;
			_type = type;
			_eventClass = eventClass;
			_mappings = new CommandMappingList(this, logger);
			_executor = new CommandExecutor(injector, _mappings.removeMapping);
			_payloadCollector = new PayloadCollector(eventClass);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function createMapper():CommandMapper
		{
			return new CommandMapper(_mappings, _executeMethodConfigurator);
		}

		public function activate():void
		{
			_dispatcher.addEventListener(_type, eventHandler);
		}

		public function deactivate():void
		{
			_dispatcher.removeEventListener(_type, eventHandler);
		}

		public function toString():String
		{
			return _eventClass + " with selector '" + _type + "'";
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function eventHandler(event:Event):void
		{
			const eventConstructor:Class = event["constructor"] as Class;

			if (_eventClass && _eventClass != Event && _eventClass != eventConstructor)
				return;

			var payload:CommandPayload = _payloadCollector.collectPayload(event);
			if (!payload)
			{
				var payloadEventClass:Class = (eventConstructor == _eventClass || (!_eventClass))
					? eventConstructor
					: Event;
				payload = new CommandPayload([event], [payloadEventClass]);
			}
			_executor.executeCommands(_mappings.getList(), payload);
		}
	}
}

