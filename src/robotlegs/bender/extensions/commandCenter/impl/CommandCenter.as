//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutionHooks;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.impl.applyHooks;
	import robotlegs.bender.framework.impl.guardsApprove;

	/**
	 * @private
	 */
	public class CommandCenter implements ICommandCenter
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector:Injector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function CommandCenter(injector:Injector):void
		{
			_injector = injector;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function execute(commandClass:Class, hooks:ICommandExecutionHooks = null):void
		{
			var mapping:ICommandMapping = new CommandMapping(commandClass);
			executeMapping(mapping, hooks);
		}

		/**
		 * @inheritDoc
		 */
		public function executeTrigger(trigger:ICommandTrigger, hooks:ICommandExecutionHooks = null):void
		{
			var mappings:Vector.<ICommandMapping> = trigger.getMappings().concat();
			var i:int;
			var n:int = mappings.length;
			for (i = 0; i < n; i++)
			{
				var mapping:ICommandMapping = mappings[i];
				executeMapping(mapping, hooks, trigger);
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function executeMapping(mapping:ICommandMapping, hooks:ICommandExecutionHooks = null, trigger:ICommandTrigger = null):void
		{
			var command:Object = null;
			hooks && hooks.mapPayload && hooks.mapPayload();
			if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector))
			{

				trigger && mapping.fireOnce && trigger.unmap(mapping.commandClass);
				const commandClass:Class = mapping.commandClass;
				command = _injector.instantiateUnmapped(commandClass);
				if (mapping.hooks.length > 0)
				{
					_injector.map(commandClass).toValue(command);
					applyHooks(mapping.hooks, _injector);
					_injector.unmap(commandClass);
				}
			}
			hooks && hooks.unmapPayload && hooks.unmapPayload();
			if (command)
			{
				"execute" in command && command.execute();
				hooks && hooks.whenCommandExecuted && hooks.whenCommandExecuted();
			}
		}
	}
}
