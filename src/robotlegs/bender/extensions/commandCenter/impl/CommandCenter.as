//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import flash.utils.Dictionary;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutionHooks;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.impl.applyHooks;
	import robotlegs.bender.framework.impl.guardsApprove;

	/**
	 * @private
	 */
	public class CommandCenter implements ICommandCenter
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/


		private var _logger:ILogger;

		/**
		 * @private
		 */
		public function set logger(value:ILogger):void{
			_logger = value;
		}

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/


		private var _injector : Injector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function CommandCenter( injector : Injector, logger : ILogger = null ) : void{
			_injector = injector;
			_logger = logger;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(trigger : ICommandTrigger, commandClass : Class):ICommandMapping
		{
			var mapping : ICommandMapping = trigger.getMappingFor(commandClass);
			if (mapping)
			{
				mapping = overwriteMapping(mapping)
			}
			else
			{
				mapping = createMapping(trigger, commandClass);
			}
			return mapping;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(trigger : ICommandTrigger, commandClass : Class ):void
		{
			const mapping:ICommandMapping = trigger.getMappingFor(commandClass);
			mapping && deleteMapping(mapping);
		}

		/**
		 * @inheritDoc
		 */
		public function unmapAll( trigger : ICommandTrigger ):void
		{
			var mappings : Vector.<ICommandMapping> = trigger.getMappings();
			if( mappings && mappings.length ){
				var i : int = mappings.length;
				while( i-- ){
					deleteMapping( mappings[ i ] );
				}
			}

		}

		/**
		 * @inheritDoc
		 */
		public function executeCommands(mappings:Vector.<ICommandMapping>, hooks:ICommandExecutionHooks) : void
		{
			//must be immutable list of mappings -> don't forget to clone
			var i : int;
			var n : int = mappings.length
			for ( i = 0; i<n; i++ ){
				var mapping : ICommandMapping = mappings[ i ];
				executeCommand(mapping, hooks);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function executeCommand( mapping : ICommandMapping, hooks: ICommandExecutionHooks ) : void{
			var command:Object = null;
			hooks.mapPayload && hooks.mapPayload();
			if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector))
			{

				mapping.fireOnce && deleteMapping( mapping );
				const commandClass:Class = mapping.commandClass;
				command = _injector.instantiateUnmapped(commandClass);
				if (mapping.hooks.length > 0)
				{
					_injector.map(commandClass).toValue(command);
					applyHooks(mapping.hooks, _injector);
					_injector.unmap(commandClass);
				}
			}
			hooks.unmapPayload && hooks.unmapPayload();
			if (command)
			{
				robotlegs.bender.extensions.commandCenter.impl.executeCommand( command );
				hooks.whenExecuted && hooks.whenExecuted();
			}
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function createMapping( trigger : ICommandTrigger, commandClass : Class ):ICommandMapping
		{
			var mapping : ICommandMapping = trigger.createMapping( commandClass );
			trigger.addMapping( mapping );
			_logger && _logger.debug('{0} mapped to {1}', [ trigger, mapping]);
			return mapping;
		}

		/**
		 * TODO: document
		 */
		protected function deleteMapping(mapping:ICommandMapping):void
		{
			var trigger : ICommandTrigger =  mapping.trigger;
			trigger.removeMapping( mapping );
			_logger && _logger.debug('{0} unmapped from {1}', [trigger, mapping]);
		}

		/**
		 * TODO: document
		 */
		protected function overwriteMapping(mapping:ICommandMapping):ICommandMapping
		{
			_logger && _logger.warn('{0} already mapped to {1}\n' +
				'If you have overridden this mapping intentionally you can use "unmap()" ' +
				'prior to your replacement mapping in order to avoid seeing this message.\n',
				[mapping.trigger, mapping]);
			deleteMapping(mapping);
			return createMapping(mapping.trigger, mapping.commandClass);
		}

	}
}
