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


		private var _strategy : ICommandMapStrategy;

		public function get strategy():ICommandMapStrategy{
			return _strategy;
		}

		public function set strategy(value:ICommandMapStrategy):void{
			_strategy = value;
		}


		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _mappings : Dictionary = new Dictionary( false );
		private var _injector : Injector;
		private var _logger:ILogger;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function CommandCenter( injector : Injector, logger : ILogger = null ) : void{
			_injector = injector;
			_logger = logger;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

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

		public function executeCommand( mapping : ICommandMapping, hooks: ICommandExecutionHooks ) : void{
			var command:Object = null;
			hooks.mapPayload && hooks.mapPayload();
			if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector))
			{

				mapping.fireOnce && unmap( mapping );
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

		public function getMappings(trigger:*):Vector.<ICommandMapping>
		{
			return _mappings[ trigger ];;
		}

		public function map(mapping:ICommandMapping):void
		{
			if (hasMapping(mapping))
			{
				overwriteMapping(mapping)
			}
			else
			{
				addMapping(mapping);
			}
		}

		public function unmap(mapping : ICommandMapping):void
		{
			if( hasMapping( mapping ) ){
				var trigger : * = mapping.trigger;
				deleteMapping( mapping );
				var mappings : Vector.<ICommandMapping> = _mappings[ trigger ];
				if( ! mappings ){
					_strategy.unregisterTrigger( trigger );
					delete _mappings[ trigger ];
				}
			}
		}

		/**
		 * TODO: document
		 */
		public function unmapAll( trigger : * ):void
		{
			var mappings : Vector.<ICommandMapping> = getMappings( trigger );
			if( mappings ){
				var i : int;
				var n : int = mappings.length;
				for ( i = 0; i<n; i++ ){
					var mapping : ICommandMapping = mappings[ i ];
					deleteMapping( mapping );
				}
			}
		}
		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		protected function hasMapping(mapping:ICommandMapping):Boolean
		{
			var trigger : * =  mapping.trigger;
			var mappings : Vector.<ICommandMapping> = getMappings( trigger );
			if( mappings ){
				var i : int;
				var n : int = mappings.length
				for ( i = 0; i<n; i++ ){
					var compared : ICommandMapping = mappings[ i ];
					if( compared.equals( mapping ) ){
						return true;
					}
				}
			}
			return false;
		}

		/**
		 * TODO: document
		 */
		protected function addMapping( mapping : ICommandMapping):void
		{
			var trigger : * =  mapping.trigger;
			var mappings : Vector.<ICommandMapping> = getOrCreateMappings( trigger );
			mappings.push( mapping );
			_logger && _logger.debug('{0} mapped to {1}', [ trigger, mapping]);
		}

		/**
		 * TODO: document
		 */
		protected function deleteMapping(mapping:ICommandMapping):void
		{
			var trigger : * =  mapping.trigger;
			var mappings : Vector.<ICommandMapping> = getMappings( trigger );
			if( mappings ){
				var i : int;
				var n : int = mappings.length;
				for ( i = 0; i<n; i++ ){
					var compared : ICommandMapping = mappings[ i ];
					if( compared.equals( mapping ) ){
						mappings.splice( i, 1 );
						break;
					}
				}
			}
			_logger && _logger.debug('{0} unmapped from {1}', [trigger, mapping]);
		}

		/**
		 * TODO: document
		 */
		protected function overwriteMapping(mapping:ICommandMapping):void
		{
			_logger && _logger.warn('{0} already mapped to {1}\n' +
				'If you have overridden this mapping intentionally you can use "unmap()" ' +
				'prior to your replacement mapping in order to avoid seeing this message.\n',
				[mapping.trigger, mapping]);
			deleteMapping(mapping);
			addMapping(mapping);
		}

		private function getOrCreateMappings( trigger : * ) : Vector.<ICommandMapping>{
			var mappings : Vector.<ICommandMapping> = getMappings( trigger );
			if( ! mappings ){
				mappings = _mappings[ trigger ] = new Vector.<ICommandMapping>();
				_strategy.registerTrigger( trigger );
			}
			return mappings;
		}

	}
}
