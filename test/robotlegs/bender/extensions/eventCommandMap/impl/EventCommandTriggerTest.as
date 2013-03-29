//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.IEventDispatcher;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import org.hamcrest.assertThat;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;

	public class EventCommandTriggerTest
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Rule]
		public var mocks:MockolateRule = new MockolateRule();

		[Mock]
		public var dispatcher:IEventDispatcher;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var trigger:EventCommandTrigger;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			trigger = new EventCommandTrigger(new Injector(), dispatcher, null, null);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_activate_adds_a_listener():void
		{
			trigger.activate();
			assertThat(dispatcher, received().method('addEventListener').once());
		}

		[Test]
		public function test_deactivate_removes_a_listener() : void{
			trigger.deactivate();
			assertThat(dispatcher, received().method('removeEventListener').once());
		}
	}
}
