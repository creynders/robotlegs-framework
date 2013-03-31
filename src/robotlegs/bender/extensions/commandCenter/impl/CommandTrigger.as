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
		/* Protected Properties                                                       */
		/*============================================================================*/

		protected var _mappingsList:Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _logger:ILogger;

		private var _mappingsByCommandClass:Dictionary = new Dictionary();

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function withLogger(value:ILogger):void
		{
			_logger = value;
		}

		/**
		 * @inheritDoc
		 */
		public function activate():void
		{
			//abstract
		}

		/**
		 * @inheritDoc
		 */
		public function deactivate():void
		{
			//abstract
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
				mapping = addMapping(commandClass);
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
				var i:int = mappings.length;
				while (i--)
				{
					deleteMapping(mappings[i]);
				}
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
			deleteMapping(mapping);
			return addMapping(mapping.commandClass);
		}
		private function deleteMapping(mapping:ICommandMapping):void
		{
			const index:int = _mappingsList.indexOf(mapping);
			if (index > -1)
			{
				var mapping:ICommandMapping = _mappingsList[index];
				delete _mappingsByCommandClass[mapping.commandClass];
				_mappingsList.splice(index, 1);
			}
			_logger && _logger.debug('{0} unmapped from {1}', [this, mapping]);
		}

		private function addMapping(commandClass:Class):ICommandMapping
		{
			var mapping:ICommandMapping = createMapping(commandClass);
			_mappingsByCommandClass[mapping.commandClass] = mapping;
			_mappingsList.push(mapping);
			_logger && _logger.debug('{0} mapped to {1}', [this, mapping]);
			return mapping;
		}
	}
}
