//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.messageCommandMap.impl
{
	import flash.utils.describeType;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingQueue;
	import robotlegs.bender.extensions.commandCenter.impl.verifyCommandClass;
	import robotlegs.bender.framework.api.IMessageDispatcher;
	import robotlegs.bender.framework.impl.applyHooks;
	import robotlegs.bender.framework.impl.guardsApprove;
	import robotlegs.bender.framework.impl.safelyCallBack;

	/**
	 * @private
	 */
	public class MessageCommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/


		private var _mappings:CommandMappingQueue = new CommandMappingQueue();

		private var _dispatcher:IMessageDispatcher;

		private var _message:Object;
        
        private var _executor : MessageCommandExecutor;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function MessageCommandTrigger(
			injector:Injector,
			dispatcher:IMessageDispatcher,
			message:Object)
		{
			_dispatcher = dispatcher;
			_message = message;
            
            _executor = new MessageCommandExecutor( this, injector.createChildInjector() );
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
            _mappings.add( mapping );
			if (_mappings.length == 1)
				addHandler();
		}

		/**
		 * @inheritDoc
		 */
		public function removeMapping(mapping:ICommandMapping):void
		{
            if (_mappings.length == 1)
                removeHandler();
            _mappings.remove( mapping );
		}

        /**
         * @inheritDoc
         */
        public function getMappings():ICommandMappingIterator
        {
            return _mappings;
        }
        
		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function verifyCommandClass(mapping:ICommandMapping):void
		{
            robotlegs.bender.extensions.commandCenter.impl.verifyCommandClass( mapping.commandClass );
		}

		private function addHandler():void
		{
			_dispatcher.addMessageHandler(_message, handleMessage);
		}

		private function removeHandler():void
		{
			_dispatcher.removeMessageHandler(_message, handleMessage);
		}

		private function handleMessage(message:Object, callback:Function):void
		{
            _executor.execute( _mappings.clone(), message, callback );
		}

    }
}
