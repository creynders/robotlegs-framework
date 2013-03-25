//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	/**
	 * TODO: document
	 */
	import flash.utils.Dictionary;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.api.ILogger;

	public class CommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _logger:ILogger;

		[PostConstruct]
		public function set logger(value:ILogger):void
		{
			_logger = value;
		}

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		// TODO:change to const
		private var _mappingsList:Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

		// TODO:change to const
		private var _mappingsByCommandClass:Dictionary = new Dictionary();

		private var _strategy:ICommandMapStrategy;

		private var _decorated:ICommandTrigger;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		public function CommandTrigger(strategy:ICommandMapStrategy, decorated:ICommandTrigger = null)
		{
			_strategy = strategy;
			_decorated = decorated || this;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function map(commandClass:Class):ICommandMapping
		{
			var mapping:ICommandMapping = getMappingFor(commandClass);
			if (mapping)
			{
				mapping = overwriteMapping(mapping)
			}
			else
			{
				mapping = createMapping(commandClass);
			}
			return mapping;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(commandClass:Class):void
		{
			const mapping:ICommandMapping = getMappingFor(commandClass);
			mapping && deleteMapping(mapping);
		}

		/**
		 * @inheritDoc
		 */
		public function unmapAll():void
		{
			var mappings:Vector.<ICommandMapping> = getMappings();
			if (mappings && mappings.length)
			{
				var i:int = mappings.length;
				while (i--)
				{
					deleteMapping(mappings[i]);
				}
			}

		}

		/**
		 * @inheritDoc
		 */
		public function getMappings():Vector.<ICommandMapping>
		{
			return _mappingsList;
		}

		/**
		 * @inheritDoc
		 */
		public function getMappingFor(commandClass:Class):ICommandMapping
		{
			return _mappingsByCommandClass[commandClass];
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function createMapping(commandClass:Class):ICommandMapping
		{
			var mapping:ICommandMapping = new CommandMapping(commandClass);
			addMapping(mapping);
			_logger && _logger.debug('{0} mapped to {1}', [_decorated, mapping]);
			return mapping;
		}

		/**
		 * TODO: document
		 */
		protected function deleteMapping(mapping:ICommandMapping):void
		{
			removeMapping(mapping);
			_logger && _logger.debug('{0} unmapped from {1}', [_decorated, mapping]);
		}

		/**
		 * TODO: document
		 */
		protected function overwriteMapping(mapping:ICommandMapping):ICommandMapping
		{
			_logger && _logger.warn('{0} already mapped to {1}\n' +
				'If you have overridden this mapping intentionally you can use "unmap()" ' +
				'prior to your replacement mapping in order to avoid seeing this message.\n',
				[_decorated, mapping]);
			removeMapping(mapping);
			return createMapping(mapping.commandClass);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function addMapping(mapping:ICommandMapping):void
		{
			_mappingsByCommandClass[mapping.commandClass] = mapping;
			_mappingsList.push(mapping);
			if (_mappingsList.length == 1)
			{
				_strategy.activate(_decorated);
			}
		}

		private function removeMapping(mapping:ICommandMapping):void
		{
			const index:int = _mappingsList.indexOf(mapping);
			if (index != -1)
			{
				delete _mappingsByCommandClass[mapping.commandClass];
				_mappingsList.splice(index, 1);
			}
			if (_mappingsList.length <= 0)
			{
				_strategy.deactivate(_decorated);
			}
		}
	}
}
