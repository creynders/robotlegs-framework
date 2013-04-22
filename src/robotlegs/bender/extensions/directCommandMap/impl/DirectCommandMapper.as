//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.directCommandMap.impl
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingList;
	import robotlegs.bender.extensions.commandCenter.api.IExecuteMethodMap;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
	import robotlegs.bender.extensions.commandCenter.impl.CommandPayload;
	import robotlegs.bender.extensions.directCommandMap.dsl.IDirectCommandConfigurator;

	public class DirectCommandMapper implements IDirectCommandConfigurator
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _mappings:ICommandMappingList;

		private var _mapping:ICommandMapping;

		private var _executor:ICommandExecutor;

		private var _executeMethodMap : IExecuteMethodMap;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function DirectCommandMapper(
			executor:ICommandExecutor,
			mappings:ICommandMappingList,
			executeMethodMap : IExecuteMethodMap,
			commandClass:Class)
		{
			_executor = executor;
			_mappings = mappings;
			_executeMethodMap = executeMethodMap;
			_mapping = new CommandMapping(commandClass);
			_mapping.setFireOnce(true);
			const executeMethod:String = _executeMethodMap.getExecuteMethodForCommandClass(_mapping.commandClass);
			executeMethod && _mapping.setExecuteMethod(executeMethod);
			_mappings.addMapping(_mapping);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function withExecuteMethod(name:String):IDirectCommandConfigurator
		{
			_mapping.setExecuteMethod(name);
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function withGuards(... guards):IDirectCommandConfigurator
		{
			_mapping.addGuards.apply(null, guards);
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function withHooks(... hooks):IDirectCommandConfigurator
		{
			_mapping.addHooks.apply(null, hooks);
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function withPayloadInjection(value:Boolean = true):IDirectCommandConfigurator
		{
			_mapping.setPayloadInjectionEnabled(value);
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function execute(payload:CommandPayload = null):void
		{
			_executor.executeCommands(_mappings.getList(), payload);
		}

		/**
		 * @inheritDoc
		 */
		public function map(commandClass:Class):IDirectCommandConfigurator
		{
			return new DirectCommandMapper(_executor, _mappings, _executeMethodMap, commandClass);
		}
	}
}
