//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.Event;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.impl.AbstractCommandExecutor;

	/**
	 * @private
	 */
	public class EventCommandExecutor extends AbstractCommandExecutor implements ICommandExecutor
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _eventClass:Class;
        
        private var _eventConstructor : Class;
        
        private var _event : Event;
        
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandExecutor(
			trigger:ICommandTrigger,
			injector:Injector,
			eventClass:Class)
		{
            super( trigger, injector );
			_eventClass = eventClass;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * Constructs and executes mapped Commands
		 * @param event The event that triggered this execution
		 */
		public function execute(event:Event):void
		{
			_eventConstructor = event["constructor"] as Class;
			if (_eventClass && _eventConstructor != _eventClass)
			{
                cleanup();
				return;
			}
            _event = event;
            
            executeCommands( _trigger.getMappings() );
            
            cleanup();
		}
        
        /*============================================================================*/
        /* Protected Functions                                                        */
        /*============================================================================*/
        
        /**
         * @inheritDoc
         */
        override protected function beforeGuarding():void
        {
            _injector.map(Event).toValue(_event);
            if (_eventConstructor != Event){
                _injector.map(_eventClass || _eventConstructor).toValue(_event);
            }
        }
        
        /**
         * @inheritDoc
         */
        override protected function beforeExecuting():void
        {
            _injector.unmap(Event);
            if (_eventConstructor != Event){
                _injector.unmap(_eventClass || _eventConstructor);
            }
        }
        
        /*============================================================================*/
        /* Private Functions                                                          */
        /*============================================================================*/
        
        private function cleanup():void
        {
            _event = null;
            _eventConstructor = null;
        }
        
       
    }
}
