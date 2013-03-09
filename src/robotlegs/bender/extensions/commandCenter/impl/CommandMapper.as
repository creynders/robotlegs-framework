//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import flash.utils.Dictionary;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @private
	 */
	public class CommandMapper implements ICommandMapper, ICommandUnmapper
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _trigger:ICommandTrigger;

		private var _logger:ILogger;
        
        private var _factory : ICommandMappingFactory 

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * Creates a Command Mapper
		 * @param trigger Trigger
		 * @param logger Logger
		 */
		public function CommandMapper(trigger:ICommandTrigger, factory : ICommandMappingFactory, logger:ILogger = null)
		{
			_trigger = trigger;
            _factory = factory;
			_logger = logger;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function toCommand(commandClass:Class):ICommandMappingConfig
		{
            var mapping : ICommandMapping = _trigger.getMappingFor( commandClass );
            if( mapping ){
                overwriteMapping( mapping )
            }else{
                mapping = createMapping( commandClass );
            }
            return mapping;
		}

		/**
		 * @inheritDoc
		 */
		public function fromCommand(commandClass:Class):void
		{
			const mapping:ICommandMapping = _trigger.getMappingFor( commandClass );
			mapping && deleteMapping(mapping);
		}

		/**
		 * @inheritDoc
		 */
		public function fromAll():void
		{
			for each (var mapping:ICommandMapping in _trigger.getMappings() )
			{
				deleteMapping(mapping);
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function createMapping(commandClass:Class):ICommandMapping
		{
            var mapping : ICommandMapping = _factory.createMapping( commandClass );
			_trigger.addMapping(mapping);
			_logger && _logger.debug('{0} mapped to {1}', [_trigger, mapping]);
            return mapping;
		}

		private function deleteMapping(mapping:ICommandMapping):void
		{
			_trigger.removeMapping(mapping);
			_logger && _logger.debug('{0} unmapped from {1}', [_trigger, mapping]);
		}

		private function overwriteMapping(mapping:ICommandMapping):ICommandMapping
		{
			_logger && _logger.warn('{0} already mapped to {1}\n' +
				'If you have overridden this mapping intentionally you can use "unmap()" ' +
				'prior to your replacement mapping in order to avoid seeing this message.\n',
				[_trigger, mapping]);
			deleteMapping(mapping);
			return createMapping(mapping.commandClass);
		}
	}
}
