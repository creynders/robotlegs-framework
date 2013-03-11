//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingList;
	import robotlegs.bender.extensions.commandCenter.impl.verifyCommandClass;

	/**
	 * @private
	 */
	public class EventCommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

        private const _mappingsByCommandClass : Dictionary = new Dictionary();
        
		private const _mappingsList:CommandMappingList = new CommandMappingList();

		private var _dispatcher:IEventDispatcher;

		private var _type:String;

		private var _executor:EventCommandExecutor;

		private var _eventClass:Class;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandTrigger(
			injector:Injector,
			dispatcher:IEventDispatcher,
			type:String,
			eventClass:Class = null)
		{
			_dispatcher = dispatcher;
			_type = type;
			_eventClass = eventClass;
            _executor = new EventCommandExecutor( this, injector, eventClass );
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function addMapping(mapping:ICommandMapping):void
		{
			verifyCommandClass(mapping);
            _mappingsByCommandClass[ mapping.commandClass ] = mapping;
			_mappingsList.head || addListener();
			_mappingsList.add(mapping);
		}

		/**
		 * @inheritDoc
		 */
		public function removeMapping(mapping:ICommandMapping):void
		{
            delete _mappingsByCommandClass[ mapping.commandClass ];
			_mappingsList.remove(mapping);
			_mappingsList.head || removeListener();
            //TODO: determine whether to unmap trigger from commandcenter when mappings.length == 0
		}

        /**
         * @inheritDoc
         */
        public function getMappings():ICommandMappingIterator
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

		private function verifyCommandClass(mapping:ICommandMapping):void
		{
            robotlegs.bender.extensions.commandCenter.impl.verifyCommandClass( mapping.commandClass );

		}

		private function addListener():void
		{
			_dispatcher.addEventListener(_type, _executor.execute);
		}

		private function removeListener():void
		{
			_dispatcher.removeEventListener(_type, _executor.execute);
		}
        
        public function getMappingFor(commandClass:Class):ICommandMapping
        {
            return _mappingsByCommandClass[ commandClass ];
        }
        
    }
}

