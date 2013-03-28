//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import mockolate.arg;
	import mockolate.expect;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand2;
	import robotlegs.bender.framework.api.ILogger;

	public class CommandMapperTest
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Rule]
		public var mocks:MockolateRule = new MockolateRule();

		[Mock]
		public var trigger:ICommandTrigger;

		[Mock]
		public var logger:ILogger;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var mapper:CommandMapper;

		private var mapping:ICommandMapping;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			mapper = new CommandMapper(trigger);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_toCommand_registers_commandClass_with_trigger():void
		{
			mapper.toCommand(NullCommand);
			assertThat(trigger, received().method('map').arg(NullCommand).once());
		}

		[Test]
		public function test_fromCommand_passes_commandClass_to_trigger_for_removal():void
		{
			mapper.fromCommand(NullCommand);
			assertThat(trigger, received().method('unmap').arg(NullCommand).once());
		}

		[Test]
		public function test_fromAll_calls_unmapAll_of_trigger():void
		{
			mapper.fromAll();
			assertThat(trigger, received().method('unmapAll').once());
		}

		[Test]
		public function test_once_sets_once_in_mapping():void
		{
			injectMapping();
			mapper.once(false);
			assertThat(mapping.fireOnce, equalTo(false));
		}

		[Test]
		public function test_withGuards_adds_guards_to_mapping():void
		{
			injectMapping();
			mapper.withGuards(GuardA, GuardB);
			assertThat(mapping.guards, array(GuardA, GuardB));
		}

		[Test]
		public function test_withHooks_adds_hooks_to_mapping():void
		{
			injectMapping();
			mapper.withHooks(HookA, HookB);
			assertThat(mapping.hooks, array(HookA, HookB));
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function injectMapping():void
		{
			mapping = new CommandMapping(NullCommand);
			stub(trigger).method('map').returns(mapping);
			mapper.toCommand(NullCommand);
		}
	}
}

class GuardA
{

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function approve():Boolean
	{
		return true;
	}
}

class GuardB
{

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function approve():Boolean
	{
		return true;
	}
}

class HookA
{

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function hook():void
	{

	}
}

class HookB
{

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function hook():void
	{

	}
}
