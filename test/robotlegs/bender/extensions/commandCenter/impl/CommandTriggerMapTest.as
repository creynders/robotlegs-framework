//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.support.CommandMapStub;

	public class CommandTriggerMapTest
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();

		[Mock]
		public var trigger:ICommandTrigger;

		[Mock]
		public var host:CommandMapStub;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var triggerMap:CommandTriggerMap;

		private var injector:Injector;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			injector = new Injector();
			triggerMap = new CommandTriggerMap()
				.withKeyFactory(host.createKey)
				.withTriggerFactory(host.createTrigger);

		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_keyFactory_is_called_with_params():void
		{
			const foo:String = 'foo';
			const bar:Object = {};
			mock(host).method('createKey').args(foo, bar).once();
			triggerMap.getOrCreateNewTrigger(foo, bar);
		}

		[Test]
		public function test_triggerFactory_is_called_with_params():void
		{
			const foo:String = 'foo';
			const bar:Object = {};
			mock(host).method('createTrigger').args(foo, bar).once();
			triggerMap.getOrCreateNewTrigger(foo, bar);
		}

		[Test]
		public function test_getOrCreateNewTrigger_calls_createTrigger_for_every_key():void
		{
			stub(host).method('createKey').returns('a', 'b');
			mock(host).method('createTrigger').returns(trigger)
				.twice(); //N.B.
			triggerMap.getOrCreateNewTrigger();
			triggerMap.getOrCreateNewTrigger();
		}

		[Test]
		public function test_trigger_is_stored_for_key():void
		{
			stub(host).method('createKey').returns('aKey');
			stub(host).method('createTrigger').returns(trigger)
				.once(); //N.B.
			var oldTrigger:ICommandTrigger = triggerMap.getOrCreateNewTrigger();
			var newTrigger:ICommandTrigger = triggerMap.getOrCreateNewTrigger();
			assertThat(newTrigger, equalTo(oldTrigger));
		}

		[Test]
		public function test_removeTrigger_removes_trigger():void
		{
			stub(host).method('createKey').returns('aKey');
			mock(host).method('createTrigger').returns(trigger)
				.twice(); //N.B.
			var oldTrigger:ICommandTrigger = triggerMap.getOrCreateNewTrigger();
			triggerMap.removeTrigger();
			var newTrigger:ICommandTrigger = triggerMap.getOrCreateNewTrigger();
		}
	}
}
