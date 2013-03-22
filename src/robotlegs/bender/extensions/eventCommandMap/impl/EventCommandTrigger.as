//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;

	/**
	 * @private
	 */
	public class EventCommandTrigger implements ICommandTrigger
	{

		private var _type:String;

		public function get type():String{
			return _type;
		}


		private var _eventClass:Class;

		public function get eventClass():Class{
			return _eventClass;
		}


		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		// TODO:change to const
		private var _mappingsList:Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

		// TODO:change to const
		private var _mappingsByCommandClass:Dictionary = new Dictionary();

		private var _strategy : ICommandMapStrategy;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandTrigger(
			strategy : ICommandMapStrategy,
			type:String,
			eventClass:Class = null)
		{
			_strategy = strategy;
			_type = type;
			_eventClass = eventClass;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function addMapping(mapping:ICommandMapping):void
		{
			_mappingsByCommandClass[mapping.commandClass] = mapping;
			_mappingsList.push( mapping );
			if( _mappingsList.length == 1 ){
				_strategy.registerTrigger( this );
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeMapping(mapping:ICommandMapping):void
		{
			delete _mappingsByCommandClass[mapping.commandClass];
			const index:int = _mappingsList.indexOf(mapping);
			if (index != -1)
			{
				_mappingsList.splice(index, 1);
			}
			if( _mappingsList.length <= 0 ){
				_strategy.unregisterTrigger( this );
			}
		}

		public function getMappingFor(commandClass:Class):ICommandMapping
		{
			return _mappingsByCommandClass[commandClass];
		}

		public function getMappings():Vector.<ICommandMapping>
		{
			return _mappingsList;
		}


		public function toString():String
		{
			return _eventClass + " with selector '" + _type + "'";
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

	}
}

