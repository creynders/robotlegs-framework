//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import mockolate.mock;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	public class CommandCenterTest
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();

		[Mock]
		public var context:IContext;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:CommandCenter;

		private var injector:Injector;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			injector = new Injector();
			stub(context).getter('injector').returns(injector);
			subject = new CommandCenter(context);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_executes_command_successfully():void
		{
			var wasExecuted:Boolean = false;
			var callback:Function = function(item:Object):void {
				wasExecuted = true;
			};
			injector.map(Function, 'reportingFunction').toValue(callback);

			subject.execute(CommandA);

			assertThat(wasExecuted, equalTo(true));
		}

		[Test]
		public function test_detains_command():void
		{
			var command:CommandA = new CommandA();

			subject.detain(command);

			assertThat(context, received().method('detain').arg(equalTo(command)).once());
		}

		[Test]
		public function test_releases_command():void
		{
			var command:CommandA = new CommandA();

			subject.release(command);

			assertThat(context, received().method('release').arg(equalTo(command)).once());
		}
	}
}

class CommandA
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunction:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function execute():void
	{
		reportingFunction(CommandA);
	}
}
