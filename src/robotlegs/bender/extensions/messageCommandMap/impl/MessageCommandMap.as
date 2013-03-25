//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.messageCommandMap.impl
{
	import flash.utils.Dictionary;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
	import robotlegs.bender.extensions.messageCommandMap.api.IMessageCommandMap;
	import robotlegs.bender.framework.api.IMessageDispatcher;

	/**
	 * @private
	 */
	public class MessageCommandMap implements IMessageCommandMap, ICommandMappingFactory
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _triggers:Dictionary = new Dictionary();

		private var _injector:Injector;

		private var _dispatcher:IMessageDispatcher;

		private var _commandCenter:ICommandExecutor;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function MessageCommandMap(
			injector:Injector,
			dispatcher:IMessageDispatcher,
			commandCenter:ICommandExecutor)
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
		public function map(message:Object):ICommandMapper
		{
            var trigger : ICommandTrigger = _commandCenter.getTrigger( message );
            if( ! trigger ){
                trigger = createTrigger( message );
                _commandCenter.map( trigger, message );
            }
            
            return createMapper( trigger );
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(message:Object):ICommandUnmapper
		{
            return null;
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		public function createTrigger(message:Object):ICommandTrigger
		{
			return new MessageCommandTrigger(_injector, _dispatcher, message);
		}

		private function getTrigger(message:Object):ICommandTrigger
		{
			return _triggers[message];
		}
        public function createMapping( commandClass : Class ) : ICommandMapping{
            return new CommandMapping( commandClass );
        }
        public function createMapper( trigger : ICommandTrigger ):ICommandMapper
        {
            return new CommandMapper( trigger, this );
        }
	}
}
