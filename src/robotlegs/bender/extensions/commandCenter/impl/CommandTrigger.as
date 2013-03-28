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
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.api.ILogger;

	public class CommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _logger:ILogger;

		public function get logger():ILogger
		{
			return _logger;
		}

		[Inject]
		public function set logger(value:ILogger):void
		{
			_logger = value;
		}

		/*============================================================================*/
		/* Protected Properties                                                       */
		/*============================================================================*/

		protected var _mappingsList:Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _mappingsByCommandClass:Dictionary = new Dictionary();

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function activate():void
		{
			//abstract, only implemented in decorators
		}

		/**
		 * @inheritDoc
		 */
		public function deactivate():void
		{
			//abstract, only implemented in decorators
		}

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
				!(_mappingsList.length) && activate();
				mapping = addNewMapping(commandClass);
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
			!(_mappingsList.length) && deactivate();
		}

		/**
		 * @inheritDoc
		 */
		public function unmapAll():void
		{
			const mappings:Vector.<ICommandMapping> = getMappings();
			if (mappings && mappings.length)
			{
				deleteAll();
				deactivate();
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
			return new CommandMapping(commandClass);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function overwriteMapping(mapping:ICommandMapping):ICommandMapping
		{
			_logger && _logger.warn('{0} already mapped to {1}\n' +
				'If you have overridden this mapping intentionally you can use "unmap()" ' +
				'prior to your replacement mapping in order to avoid seeing this message.\n',
				[this, mapping]);
			removeMapping(mapping);
			return addMapping(mapping.commandClass);
		}

		private function addNewMapping(commandClass:Class):ICommandMapping
		{
			var mapping:ICommandMapping = addMapping(commandClass);
			_logger && _logger.debug('{0} mapped to {1}', [this, mapping]);
			return mapping;
		}

		private function deleteMapping(mapping:ICommandMapping):void
		{
			removeMapping(mapping);
			_logger && _logger.debug('{0} unmapped from {1}', [this, mapping]);
		}

		private function deleteAll():void
		{
			if (_logger)
			{
				var i:int = _mappingsList.length;
				while (i--)
				{
					var mapping:ICommandMapping = _mappingsList[i];
					delete _mappingsByCommandClass[mapping.commandClass];
					_mappingsList.splice(i, 1);
					_logger && _logger.debug('{0} unmapped from {1}', [this, mapping]);
				}
			}
			else
			{
				_mappingsList = new Vector.<ICommandMapping>();
				_mappingsByCommandClass = new Dictionary();
			}
		}

		private function addMapping(commandClass:Class):ICommandMapping
		{
			var mapping:ICommandMapping = createMapping(commandClass);
			_mappingsByCommandClass[mapping.commandClass] = mapping;
			_mappingsList.push(mapping);
			return mapping;
		}

		private function removeMapping(mapping:ICommandMapping):void
		{
			const index:int = _mappingsList.indexOf(mapping);
			if (index > -1)
			{
				var mapping:ICommandMapping = _mappingsList[index];
				delete _mappingsByCommandClass[mapping.commandClass];
				_mappingsList.splice(index, 1);
			}
		}
	}
}
