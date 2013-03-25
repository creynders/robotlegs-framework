//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import mockolate.runner.MockolateRule;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.support.CallbackCommand;
	import robotlegs.bender.extensions.commandCenter.support.CallbackCommand2;
	import robotlegs.bender.extensions.commandCenter.support.NullCommandExecutionHooks;

	public class CommandCenterTest
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Rule]
		public var mockolateRule : MockolateRule = new MockolateRule();

		[Mock]
		public var strategy : ICommandMapStrategy;

		[Mock]
		public var trigger : ICommandTrigger;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var commandCenter:ICommandExecutor;

		private var reportedExecutions:Array;

		private var mappings : Array;

		private var injector : Injector;

		private function get mappingsVector() : Vector.<ICommandMapping>{
			return Vector.<ICommandMapping>( mappings );
		}
		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			injector = new Injector();
			injector.map(Function, "reportingFunction").toValue(reportingFunction);
			reportedExecutions = [];
			mappings = [];
			commandCenter = new CommandExecutor( injector );
			commandCenter.strategy = strategy;
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_map_stores_mapping():void
		{
			commandCenter.map( trigger,);
			assertThat(commandCenter.getMappings( trigger ), array( mapping ) );
		}

		[Test]
		public function test_unmap_removes_mapping():void
		{
			var mapping : CommandMapping = new CommandMapping( trigger );
			commandCenter.map( mapping );
			commandCenter.unmap( mapping );
			assertThat(commandCenter.getMappings( trigger ), nullValue() );
		}

		[Test]
		public function test_getMappings_returns_mappings() : void{
			mapCommands( CallbackCommand, CallbackCommand2 );
			assertThat( commandCenter.getMappings( trigger ), array( mappings ) );
		}

		[Test]
		public function test_unmapAll_unmaps_all() : void{
			mapCommands( CallbackCommand, CallbackCommand2 );
			commandCenter.unmapAll( trigger );
			//TODO: determine whether this should be nullValue() instead??
			assertThat( commandCenter.getMappings( trigger ), array() );
		}

		[Test]
		public function test_command_without_execute_method_is_still_constructed():void
		{

			commandCenter.executeCommand( addMapping( trigger, CommandWithoutExecute ), new NullCommandExecutionHooks() );
			assertThat( reportedExecutions, array( CommandWithoutExecute ) );
		}

		[Test]
		public function test_command_executes_successfully():void
		{
			assertThat(commandExecutionCount(1), equalTo(1));
		}

		[Test]
		public function test_command_executes_repeatedly():void
		{
			assertThat(commandExecutionCount(5), equalTo(5));
		}

		[Test]
		public function test_fireOnce_command_removes_mapping():void
		{
			assertThat(commandExecutionCountFireOnce());
			assertThat( commandCenter.getMappings( trigger ), array() );
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		private function commandExecutionCountFireOnce(totalEvents:uint = 1):uint
		{
			return commandExecutionCount(totalEvents, true);
		}

		private function commandExecutionCount(totalEvents:int = 1, oneShot:Boolean = false, guards:Array = null, hooks:Array = null):uint
		{
			var executeCount:uint = 0;
			injector.map(Function, 'executeCallback').toValue(function():void
			{
				executeCount++;
			});
			while (totalEvents--)
			{
				var mapping:ICommandMapping = addMapping(trigger + totalEvents, CallbackCommand);
				mapping.setFireOnce(oneShot);
				guards && mapping.addGuards.apply(mapping, guards);
				hooks && mapping.addHooks.apply(mapping, hooks);
			}

			commandCenter.executeCommands( mappingsVector, new NullCommandExecutionHooks() );
			injector.unmap(Function, 'executeCallback');
			return executeCount;
		}


		private function mapCommands( ...commandClasses ) : void{
			while( commandClasses.length > 0 ){
				addMapping( trigger, commandClasses.shift() );
			}
		}

		private function addMapping( trigger: String, commandClass:Class):ICommandMapping
		{

			var mapping:CommandMapping = new CommandMapping(trigger, commandClass);
			commandCenter.map( mapping );
			mappings.push(mapping);
			return mapping;
		}

		private function reportingFunction(item:Object):void
		{
			reportedExecutions.push(item);
		}

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

