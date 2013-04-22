//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter
{
	import robotlegs.bender.extensions.commandCenter.api.IExecuteMethodConfigurator;
	import robotlegs.bender.extensions.commandCenter.impl.ExecuteMethodConfigurator;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class CommandCenterExtension implements IExtension
	{

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function extend(context:IContext):void
		{
			context.injector.map(IExecuteMethodConfigurator).toSingleton(ExecuteMethodConfigurator);
		}
	}
}