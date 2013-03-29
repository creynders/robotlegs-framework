//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.verify;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.text.containsString;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand2;
	import robotlegs.bender.extensions.commandCenter.support.ReportingCommandTrigger;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @author creynder
	 */
	public class CommandTriggerTest
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();

		[Mock]
		public var logger:ILogger;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:ICommandTrigger;

		private var injector:Injector;

		private var reported:Array;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			reported = [];
			injector = new Injector();
			injector.map(Function, 'reportingFunction')
				.toValue(reportingFunction);
			subject = injector.instantiateUnmapped(ReportingCommandTrigger);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_trigger_is_activated_when_first_mapping_is_added():void
		{
			subject.map(NullCommand);

			assertThat(reported, array(ReportingCommandTrigger.ACTIVATE));
		}

		[Test]
		public function trigger_is_not_activated_when_second_mapping_is_added():void
		{
			subject.map(NullCommand);
			clearReported();

			subject.map(NullCommand2);

			assertThat(reported, array());
		}

		[Test]
		public function trigger_is_not_activated_when_mapping_overwritten():void
		{
			subject.map(NullCommand);
			clearReported();

			subject.map(NullCommand);

			assertThat(reported, array());
		}

		[Test]
		public function trigger_is_deactivated_when_last_mapping_is_removed():void
		{
			subject.map(NullCommand);
			subject.map(NullCommand2);
			subject.unmap(NullCommand);
			clearReported();

			subject.unmap(NullCommand2);

			assertThat( reported, array( ReportingCommandTrigger.DEACTIVATE ));
		}

		[Test]
		public function trigger_is_deactivated_when_all_mappings_are_removed():void
		{
			subject.map(NullCommand);
			subject.map(NullCommand2);
			clearReported();

			subject.unmapAll();

			assertThat( reported, array( ReportingCommandTrigger.DEACTIVATE ));
		}

		[Test]
		public function trigger_is_not_deactivated_when_all_mappings_removed_multiple_times():void
		{
			subject.map(NullCommand);
			subject.map(NullCommand2);
			subject.unmapAll();
			clearReported();

			subject.unmapAll();

			assertThat( reported, array());
		}

		[Test]
		public function trigger_is_not_deactivated_when_second_last_mapping_is_removed():void
		{
			subject.map(NullCommand);
			subject.map(NullCommand2);
			clearReported();

			subject.unmap(NullCommand);

			assertThat( reported, array());
		}

		[Test]
		public function warning_logged_when_mapping_overwritten():void
		{
			subject.withLogger(logger);
			subject.map(NullCommand);

			subject.map(NullCommand);

			assertThat( logger, received().method( 'warn' ).args(containsString("already mapped"), notNullValue()).once() );
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function clearReported() : void{
			reported = [];
		}
		private function reportingFunction(item:Object):void
		{
			reported.push(item);
		}
	}
}
