package robotlegs.bender.extensions.commandCenter
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;

	import robotlegs.bender.extensions.commandCenter.api.IExecuteMethodMap;
	import robotlegs.bender.framework.impl.Context;

	public class CommandCenterExtensionTest{
		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var context:Context;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			context = new Context();
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function executeMethodMap_is_mapped_into_injector():void
		{
			var actual:Object = null;
			context.install(CommandCenterExtension);
			context.whenInitializing( function():void {
				actual = context.injector.getInstance(IExecuteMethodMap);
			});
			context.initialize();
			assertThat(actual, instanceOf(IExecuteMethodMap));
		}
	}
}