//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.impl.applyHooks;
	import robotlegs.bender.framework.impl.guardsApprove;

	/**
	 * @private
	 */
	public class CommandExecutor implements ICommandExecutor
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector:Injector;

		private var _trigger : ICommandTrigger;

		private var _mapPayload:Function;

		private var _unmapPayload:Function;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		public function CommandExecutor(
			injector:Injector,
			trigger : ICommandTrigger)
		{
			_injector = injector;
			_trigger = trigger;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function withPayloadMapper(mapPayload:Function):ICommandExecutor
		{
			_mapPayload = mapPayload;
			return this;
		}

		public function withPayloadUnmapper(unmapPayload:Function):ICommandExecutor
		{
			_unmapPayload = unmapPayload;
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function executeCommands(mappings:Vector.<ICommandMapping>):void
		{
			const n:int = mappings.length;
			var i:int;
			for (i = 0; i < n; i++)
			{
				executeMapping( mappings[i] );
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function executeMapping(mapping:ICommandMapping):void
		{
			var command:Object = null;
			_mapPayload && _mapPayload();
			if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector))
			{
				mapping.fireOnce && _trigger.unmap( mapping.commandClass );
				const commandClass:Class = mapping.commandClass;
				command = _injector.instantiateUnmapped(commandClass);
				if (mapping.hooks.length > 0)
				{
					_injector.map(commandClass).toValue(command);
					applyHooks(mapping.hooks, _injector);
					_injector.unmap(commandClass);
				}
			}
			_unmapPayload && _unmapPayload(mapping);
			if (command)
			{
				"execute" in command && command.execute();
			}
		}
	}
}
