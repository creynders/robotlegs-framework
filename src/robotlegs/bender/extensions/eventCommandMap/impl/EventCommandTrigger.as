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
	import robotlegs.bender.extensions.commandCenter.impl.CommandTrigger;

	/**
	 * @private
	 */
	public class EventCommandTrigger implements ICommandTrigger
	{

		private var _type:String;
		/**
		 * TODO: document
		 */
		public function get type():String{
			return _type;
		}


		private var _eventClass:Class;
		/**
		 * TODO: document
		 */
		public function get eventClass():Class{
			return _eventClass;
		}

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _base : CommandTrigger;

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
			_base = new CommandTrigger( strategy, this );
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
			_base.addMapping( mapping );
		}

		/**
		 * @inheritDoc
		 */
		public function removeMapping(mapping:ICommandMapping):void
		{
			_base.removeMapping( mapping );
		}

		public function getMappingFor(commandClass:Class):ICommandMapping
		{
			return _base.getMappingFor( commandClass );
		}

		public function getMappings():Vector.<ICommandMapping>
		{
			return _base.getMappings();
		}

		public function createMapping(commandClass:Class):ICommandMapping
		{
			return _base.createMapping(commandClass );
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

