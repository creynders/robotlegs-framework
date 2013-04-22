//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.support.ExecuteTaggedClassReportingMethodCommand;

	public class ExecuteMethodConfiguratorTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:ExecuteMethodConfigurator;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			subject = new ExecuteMethodConfigurator();
		}

		[Test]
		public function configures_execute_method() : void{
			const mapping : ICommandMapping = new CommandMapping(ExecuteTaggedClassReportingMethodCommand);
			subject.configureExecuteMethod(mapping);
			assertThat(mapping.executeMethod, equalTo('report'));
		}
	}
}
