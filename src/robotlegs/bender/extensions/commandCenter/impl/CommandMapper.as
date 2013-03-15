//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @author creynder
	 */
	public class CommandMapper
	{

		private var _logger:ILogger;
		[PostConstruct]
		public function set logger(value:ILogger):void{
			_logger = value;
		}


		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _trigger:ICommandTrigger;

		private var _factory:ICommandMappingFactory;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function CommandMapper(trigger:ICommandTrigger, factory:ICommandMappingFactory, logger:ILogger = null)
		{
			_trigger = trigger;
			_factory = factory;
			_logger = logger;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		public function mapCommand(commandClass:Class):ICommandMapping
		{
			var mapping:ICommandMapping = _trigger.getMappingFor(commandClass);
			if (mapping)
			{
				overwriteMapping(mapping)
			}
			else
			{
				mapping = createMapping(commandClass);
			}
			return mapping;
		}

		/**
		 * TODO: document
		 */
		public function unmapCommand(commandClass:Class):void
		{
			const mapping:ICommandMapping = _trigger.getMappingFor(commandClass);
			mapping && deleteMapping(mapping);
		}

		/**
		 * TODO: document
		 */
		public function unmapAll():void
		{
			var mappings:ICommandMappingCollection = _trigger.getMappings();
			for (var mapping:ICommandMapping = mappings.first(); mapping; mapping = mappings.next())
			{
				deleteMapping(mapping);
			}
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function createMapping(commandClass:Class):ICommandMapping
		{
			var mapping:ICommandMapping = _factory.createMapping(commandClass);
			_trigger.addMapping(mapping);
			_logger && _logger.debug('{0} mapped to {1}', [_trigger, mapping]);
			return mapping;
		}

		/**
		 * TODO: document
		 */
		protected function deleteMapping(mapping:ICommandMapping):void
		{
			_trigger.removeMapping(mapping);
			_logger && _logger.debug('{0} unmapped from {1}', [_trigger, mapping]);
		}

		/**
		 * TODO: document
		 */
		protected function overwriteMapping(mapping:ICommandMapping):ICommandMapping
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
