//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;

	/**
	 * @private
	 */
	public class CommandMapper implements ICommandMapper, ICommandMappingConfig, ICommandUnmapper
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _commandCenter:ICommandCenter;

		private var _mapping : ICommandMapping;

		private var _trigger : ICommandTrigger;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function CommandMapper(commandCenter : ICommandCenter, trigger : ICommandTrigger )
		{
			_commandCenter = commandCenter;
			_trigger = trigger;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function toCommand(commandClass:Class):ICommandMappingConfig
		{
			_mapping = _commandCenter.map( _trigger, commandClass );
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function once(value:Boolean = true):ICommandMappingConfig
		{
			_mapping.setFireOnce(value);
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function withGuards(... guards):ICommandMappingConfig
		{
			_mapping.addGuards.apply(null, guards);
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function withHooks(... hooks):ICommandMappingConfig
		{
			_mapping.addHooks.apply(null, hooks);
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function fromAll():void
		{
			_commandCenter.unmapAll( _trigger );
		}

		/**
		 * @inheritDoc
		 */
		public function fromCommand(commandClass:Class):void
		{

			_commandCenter.unmap(_trigger, commandClass);
		}
	}
}