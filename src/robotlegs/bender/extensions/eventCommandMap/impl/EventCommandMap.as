//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
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
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	/**
	 * @private
	 */
	public class EventCommandMap implements IEventCommandMap, ICommandMappingFactory
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
		public function EventCommandMap(
			injector:Injector,
			dispatcher:IEventDispatcher,
			commandCenter:ICommandCenter)
		{
			_injector = injector;
			_dispatcher = dispatcher;
			_commandCenter = commandCenter;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(type:String, eventClass:Class = null):ICommandMapper
		{
            var key : String = getKey( type, eventClass );
            var trigger : ICommandTrigger = _commandCenter.getTrigger( key );
            if( ! trigger ){
                trigger = createTrigger( type, eventClass );
                _commandCenter.map( trigger, key );
            }
            return createMapper( trigger );
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(type:String, eventClass:Class = null):ICommandUnmapper
		{
            return null;
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

        public function createTrigger(type:String, eventClass:Class = null):ICommandTrigger
		{
            var trigger : EventCommandTrigger = new EventCommandTrigger(_injector, _dispatcher, type, eventClass);
            return trigger;
		}

        public function createMapper( trigger : ICommandTrigger ):ICommandMapper
        {
            return new CommandMapper( trigger, this );
        }
        
        
        public function createMapping( commandClass : Class ) : ICommandMapping{
            return new CommandMapping( commandClass );
        }
        
        /*============================================================================*/
        /* Private Functions                                                          */
        /*============================================================================*/
        
        private function getKey( type:String, eventClass:Class = null ) : String{
            return type + eventClass;
        }
        
	}
}
