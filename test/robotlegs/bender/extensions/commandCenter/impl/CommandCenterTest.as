//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import mockolate.expect;
	import mockolate.mock;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	import mockolate.verify;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.support.CallbackCommand;
	import robotlegs.bender.extensions.commandCenter.support.CallbackCommand2;
	import robotlegs.bender.extensions.commandCenter.support.CommandMapStub;
	import robotlegs.bender.extensions.commandCenter.support.NullCommandExecutionHooks;

	public class CommandCenterTest
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

		private var commandCenter:ICommandCenter;

		private var injector:Injector;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			injector = new Injector();
			commandCenter = new CommandCenter()
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
			commandCenter.getOrCreateNewTrigger(foo, bar);
		}

		[Test]
		public function test_triggerFactory_is_called_with_params():void
		{
			const foo:String = 'foo';
			const bar:Object = {};
			mock(host).method('createTrigger').args(foo, bar).once();
			commandCenter.getOrCreateNewTrigger(foo, bar);
		}

		[Test]
		public function test_getTriggerByKey_returns_identical_trigger_when_identical_key():void
		{
			const foo:String = 'foo';
			const bar:Object = {};
			stub(host).method('createKey').returns('aKey');
			stub(host).method('createTrigger').args(foo, bar).returns(trigger).once();
			var oldTrigger:ICommandTrigger = commandCenter.getOrCreateNewTrigger(foo, bar);
			var newTrigger:ICommandTrigger = commandCenter.getOrCreateNewTrigger(foo, bar);
			assertThat(newTrigger, equalTo(oldTrigger));
		}

		[Test]
		public function test_unMapTriggerFromKey_removes_trigger():void
		{
			const foo:String = 'foo';
			const bar:Object = {};
			stub(host).method('createKey').returns('aKey');
			mock(host).method('createTrigger').args(foo, bar).returns(trigger).twice();
			var oldTrigger:ICommandTrigger = commandCenter.getOrCreateNewTrigger(foo, bar);
			commandCenter.removeTrigger(foo, bar);
			var newTrigger:ICommandTrigger = commandCenter.getOrCreateNewTrigger(foo, bar);
		}

		[Test]
		public function test_createCallback_returns_callback():void
		{
			var called:Boolean = false;
			var handler:Function = function(... params):void {
				called = true;
			};
			var callback:Function = commandCenter.createCallback(trigger, handler);
			callback();

			assertThat(called, equalTo(true));
		}

		[Test]
		public function test_created_callback_passes_trigger():void
		{
			var passed:ICommandTrigger;
			var handler:Function = function(... params):void {
				passed = params.shift();
			};
			var callback:Function = commandCenter.createCallback(trigger, handler);
			callback();

			assertThat(passed, equalTo(trigger));
		}

		[Test]
		public function test_created_callback_passes_parameters():void
		{
			const foo:String = 'foo';
			const bar:Object = {};
			var actual:Array;
			var handler:Function = function(... params):void {
				actual = params;
			};
			var callback:Function = commandCenter.createCallback(trigger, handler);
			callback( foo, bar );
			var expected : Array= [ trigger, foo, bar ];
			assertThat( actual, array(expected));
		}

		[Test]
		public function test_removeCallBack_returns_removed_callback() : void{
			var created:Function = commandCenter.createCallback(trigger, function() : void{});
			var removed : Function = commandCenter.removeCallback(trigger);
			assertThat( removed, equalTo(created));
		}
	}
}
