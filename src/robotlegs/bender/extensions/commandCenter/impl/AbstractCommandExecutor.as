//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	/**
	 * @author creynder
	 */
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.framework.impl.applyHooks;
	import robotlegs.bender.framework.impl.guardsApprove;

	/**
	 *
	 * @author creynder
	 *
	 */
	public class AbstractCommandExecutor
	{

		/*============================================================================*/
		/* Protected Properties                                                       */
		/*============================================================================*/

		protected var _trigger:ICommandTrigger;

		protected var _injector:Injector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function AbstractCommandExecutor(trigger:ICommandTrigger,
			injector:Injector)
		{
			_trigger = trigger;
			_injector = injector;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function executeCommands(mappings:ICommandMappingCollection):void
		{
			for (var mapping:ICommandMapping = mappings.first(); mapping; mapping = mappings.next())
			{
				executeCommand(mapping);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function executeCommand(mapping:ICommandMapping):void
		{
			var command:Object = null;
			mapPayload();
			if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector))
			{

				mapping.fireOnce && _trigger.removeMapping(mapping);
				const commandClass:Class = mapping.commandClass;
				command = _injector.instantiateUnmapped(commandClass);
				if (mapping.hooks.length > 0)
				{
					_injector.map(commandClass).toValue(command);
					applyHooks(mapping.hooks, _injector);
					_injector.unmap(commandClass);
				}
			}
			unmapPayload();
			if (command)
			{
				command.execute();
				whenCommandExecuted();
			}
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function mapPayload():void
		{
		}

		/**
		 * TODO: document
		 */
		protected function unmapPayload():void
		{
		}

		/**
		 * TODO: document
		 */
		protected function whenCommandExecuted():void
		{
		}
	}
}