//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.IEventDispatcher;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingBuilder;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandCenter;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingBuilder;
	import robotlegs.bender.extensions.commandCenter.impl.NullCommandUnmapper;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	/**
	 * @private
	 */
	public class EventCommandMap implements IEventCommandMap, ICommandMappingFactory
	{

		/*============================================================================*/
		/* Protected Properties                                                       */
		/*============================================================================*/

		protected const NULL_UNMAPPER:ICommandUnmapper = new NullCommandUnmapper();

		protected var _injector:Injector;

		protected var _dispatcher:IEventDispatcher;

		protected var _commandCenter:ICommandCenter;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMap(
			injector:Injector,
			dispatcher:IEventDispatcher,
			commandCenter:ICommandCenter = null)
		{
			_injector = injector;
			_dispatcher = dispatcher;
			_commandCenter = commandCenter || new CommandCenter();
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(type:String, eventClass:Class = null):ICommandMappingBuilder
		{
			var key:String = getKey(type, eventClass);
			var trigger:ICommandTrigger = _commandCenter.getTrigger(key);
			if (!trigger)
			{
				trigger = createTrigger(type, eventClass);
				_commandCenter.map(trigger, key);
			}
			return createBuilder(trigger);
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(type:String, eventClass:Class = null):ICommandUnmapper
		{
			var key:String = getKey(type, eventClass);
			var trigger:ICommandTrigger = _commandCenter.getTrigger(key);
			var unmapper:ICommandUnmapper;
			if (trigger)
			{
				unmapper = createBuilder(trigger);
			}
			else
			{
				unmapper = NULL_UNMAPPER;
			}
			return unmapper;
		}

		/**
		 * @inheritDoc
		 */
		public function createMapping(commandClass:Class):ICommandMapping
		{
			return new CommandMapping(commandClass);
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		protected function createTrigger(type:String, eventClass:Class = null):ICommandTrigger
		{
			return new EventCommandTrigger(_injector, _dispatcher, type, eventClass);
		}

		protected function createBuilder(trigger:ICommandTrigger):CommandMappingBuilder
		{
			return new CommandMappingBuilder(trigger, this);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function getKey(type:String, eventClass:Class = null):String
		{
			return type + eventClass;
		}
	}
}
