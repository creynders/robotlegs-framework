//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl.execution
{
	import flash.utils.Dictionary;
	import robotlegs.bender.extensions.commandCenter.api.IExecuteMethodMap;

	public class ExecuteMethodMap implements IExecuteMethodMap
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _executeMethodsByCommandClass:Dictionary = new Dictionary();

		private var _executeReflector:ExecutionReflector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function ExecuteMethodMap()
		{
			_executeReflector = new ExecutionReflector();
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function getExecuteMethodForCommandClass(commandClass:Class):String
		{
			var executeMethod:String;
			if (!_executeMethodsByCommandClass.hasOwnProperty(commandClass))
			{
				executeMethod = _executeReflector.describeExecutionMethodForClass(commandClass);
				_executeMethodsByCommandClass[commandClass] = executeMethod;
			}
			else
			{
				executeMethod = _executeMethodsByCommandClass[commandClass];
			}
			return executeMethod;
		}
	}
}
