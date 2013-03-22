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
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;

	public class CommandMapper implements ICommandMapper, ICommandMappingConfig, ICommandUnmapper
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _commandCenter:ICommandCenter;

		private var _mapping : ICommandMapping;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function CommandMapper(commandCenter : ICommandCenter, mapping : ICommandMapping)
		{
			_commandCenter = commandCenter;
			_mapping = mapping;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function toCommand(commandClass:Class):ICommandMappingConfig
		{
			_mapping.setCommandClass( commandClass );
			_commandCenter.map( _mapping );
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
			_commandCenter.unmapAll( _mapping.trigger );
		}

		/**
		 * @inheritDoc
		 */
		public function fromCommand(commandClass:Class):void
		{
			_mapping.setCommandClass( commandClass );
			_commandCenter.unmap(_mapping);
		}
	}
}