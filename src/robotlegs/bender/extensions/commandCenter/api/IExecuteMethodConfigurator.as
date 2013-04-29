//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{

	public interface IExecuteMethodConfigurator
	{

		/**
		 * Configures the execute method for a given mapping
		 * @param mapping The Command mapping
		 */
		function configureExecuteMethod( mapping : ICommandMapping ) : void;
	}
}
