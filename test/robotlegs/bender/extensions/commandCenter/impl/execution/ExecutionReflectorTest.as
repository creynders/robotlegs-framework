//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl.execution
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import robotlegs.bender.extensions.commandCenter.support.ExecuteTaggedClassReportingMethodCommand;
	import robotlegs.bender.extensions.commandCenter.support.MultipleExecuteTaggedMethodsCommand;

	public class ExecutionReflectorTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:ExecutionReflector;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function setup():void
		{
			subject = new ExecutionReflector();
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function describes_execution_method_as_null_when_tag_not_found():void
		{
			assertThat(subject.describeExecutionMethodForClass(Class), nullValue());
		}

		[Test]
		public function describes_execution_method_when_tag_found():void
		{
			assertThat(subject.describeExecutionMethodForClass(ExecuteTaggedClassReportingMethodCommand), equalTo('report'));
		}

		[Test(expects="robotlegs.bender.extensions.commandCenter.impl.execution.ExecutionReflectorError")]
		public function error_is_thrown_when_multiple_execute_tags_found():void
		{
			subject.describeExecutionMethodForClass(MultipleExecuteTaggedMethodsCommand);
		}
	}
}
