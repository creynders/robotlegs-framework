//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import flash.utils.describeType;

	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.IExecuteMethodConfigurator;
	import robotlegs.bender.extensions.commandCenter.api.ExecuteMethodConfiguratorError;

	public class ExecuteMethodConfigurator implements IExecuteMethodConfigurator
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _executeMethodsByCommandClass:Object = {};

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function configureExecuteMethod(mapping:ICommandMapping):void
		{
			const executeMethod:String = getExecuteMethodForCommandClass(mapping.commandClass);
			executeMethod && mapping.setExecuteMethod(executeMethod);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function getExecuteMethodForCommandClass(commandClass:Class):String
		{
			var executeMethod:String;
			if (!_executeMethodsByCommandClass.hasOwnProperty(commandClass))
			{
				executeMethod = describeExecutionMethodForClass(commandClass);
				//caches possible `null` values to indicate the commandClass has been processed
				_executeMethodsByCommandClass[String(commandClass)] = executeMethod;
			}
			else
			{
				executeMethod = _executeMethodsByCommandClass[commandClass];
			}
			return executeMethod;
		}

		public function describeExecutionMethodForClass(type:Class):String
		{
			var factoryDescription:XML = describeType(type).factory[0];
			var list:XMLList = factoryDescription.method.metadata.(@name == 'Execute');
			switch (list.length())
			{
				case 1:
					var memberDescription:XML = list[0].parent();
					return memberDescription.attribute('name');
				case 0:
					return null;
				default:
					throw new ExecuteMethodConfiguratorError('Only one Execute-tagged method allowed');
			}
		}

	}
}
