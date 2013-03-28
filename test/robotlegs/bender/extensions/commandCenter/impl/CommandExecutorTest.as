//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;
	import robotlegs.bender.framework.impl.guardSupport.GrumpyGuard;
	import robotlegs.bender.framework.impl.guardSupport.HappyGuard;

	public class CommandExecutorTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var injector:Injector;

		private var subject:CommandExecutor;

		private var reportedExecutions:Array;

		private var mappings:Vector.<ICommandMapping>;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			mappings = new Vector.<ICommandMapping>();
			reportedExecutions = [];
			injector = new Injector();
			injector.map(Function, "reportingFunction").toValue(reportingFunction);
			subject = new CommandExecutor(injector);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_command_is_executed():void
		{
			addMapping();

			executeCommands();

			assertThat(reportedExecutions, array(CommandA));
		}

		[Test]
		public function test_command_is_executed_repeatedly():void
		{
			addMappings(5);

			executeCommands();

			assertThat(reportedExecutions.length, equalTo(5));
		}

		[Test]
		public function test_fireOnce_command_calls_unmapper():void
		{
			addMapping(NullCommand)
				.setFireOnce(true);
			var unmapperIsCalled:Boolean = false;
			var unmapper:Function = function():void {
				unmapperIsCalled = true;
			}
			subject.withCommandClassUnmapper(unmapper);

			executeCommands();

			assertThat(unmapperIsCalled, equalTo(true));
		}

		[Test]
		public function test_hooks_are_called():void
		{
			var hookCount:uint = 0;
			var hook:Function = function hook_callback():void {
				hookCount++;
			};
			addMapping(NullCommand)
				.addHooks(hook, hook, hook);

			executeCommands();

			assertThat(hookCount, equalTo(3));
		}

		[Test]
		public function test_command_executes_when_the_guard_allows():void
		{
			addMapping()
				.addGuards(HappyGuard);

			executeCommands();

			assertThat(reportedExecutions, array(CommandA));
		}

		[Test]
		public function test_command_does_not_execute_when_any_guards_denies():void
		{
			addMapping()
				.addGuards(HappyGuard, GrumpyGuard);

			executeCommands();

			assertThat(reportedExecutions, array());
		}

		[Test]
		public function test_execution_sequence_is_guard_command_guard_command_with_multiple_mappings():void
		{
			addMapping(CommandA)
				.addGuards(GuardA);
			addMapping(CommandB)
				.addGuards(GuardB);

			executeCommands();

			assertThat(reportedExecutions, array(
				GuardA,
				CommandA,
				GuardB,
				CommandB
				));
		}

		[Test]
		public function test_execution_sequence_is_guard_hook_command():void
		{
			addMapping()
				.addGuards(GuardA)
				.addHooks(HookA);

			executeCommands();

			assertThat(reportedExecutions, array(
				GuardA,
				HookA,
				CommandA
				));
		}

		[Test]
		public function test_allowed_commands_get_executed_after_denied_command():void
		{
			addMapping(CommandA)
				.addGuards(GrumpyGuard);
			addMapping(CommandB);

			executeCommands();

			assertThat(reportedExecutions, array(CommandB));
		}

		[Test]
		public function test_phases_called_in_order():void
		{
			addMapping(CommandA)
				.addGuards(GuardA)
				.addHooks(HookA);
			var payloadMapper:Function = function():void {
				reportingFunction(payloadMapper);
			};
			var payloadUnmapper:Function = function():void {
				reportingFunction(payloadUnmapper);
			};
			subject
				.withPayloadMapper(payloadMapper)
				.withPayloadUnmapper(payloadUnmapper);

			executeCommands();

			assertThat(reportedExecutions, array(
				payloadMapper,
				GuardA,
				HookA,
				payloadUnmapper,
				CommandA
				));
		}

		[Test]
		public function test_execute_command_without_execute_method():void
		{
			addMapping(CommandWithoutExecute);

			executeCommands();

			assertThat(reportedExecutions, array(CommandWithoutExecute));
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function addMapping(commandClass:Class = null):ICommandMapping
		{

			var mapping:ICommandMapping = new CommandMapping(commandClass || CommandA);
			mappings.push(mapping);
			return mapping;
		}

		private function addMappings(totalEvents:uint = 1, commandClass:Class = null):void
		{
			while (totalEvents--)
			{
				addMapping(commandClass);
			}
		}

		private function executeCommands():void
		{
			subject.executeCommands(mappings);
		}

		private function reportingFunction(item:Object):void
		{
			reportedExecutions.push(item);
		}
	}
}

class CommandA
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function execute():void
	{
		reportingFunc && reportingFunc(CommandA);
	}
}

class CommandB
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function execute():void
	{
		reportingFunc && reportingFunc(CommandB);
	}
}

class CommandWithoutExecute
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	[PostConstruct]
	public function init():void
	{
		reportingFunc(CommandWithoutExecute);
	}
}

class GuardA
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function approve():Boolean
	{
		reportingFunc && reportingFunc(GuardA);
		return true
	}
}

class GuardB
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function approve():Boolean
	{
		reportingFunc && reportingFunc(GuardB);
		return true
	}
}

class HookA
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function hook():void
	{
		reportingFunc && reportingFunc(HookA);
	}
}
