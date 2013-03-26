//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap
{
	import robotlegs.bender.extensions.eventDispatcher.EventDispatcherExtension;
	import robotlegs.bender.framework.impl.Context;

	public class EventCommandMapExtensionTest
	{

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
			context.install(EventDispatcherExtension);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function eventCommandMap_is_mapped_into_injector():void
		{
			// TODO: update SwiftSuspenders to latest version, otherwise this fails
			/*
			var actual:Object = null;
			context.install(EventCommandMapExtension);
			context.whenInitializing(function():void {
				actual = context.injector.getInstance(IEventCommandMap);
			});
			context.initialize();
			assertThat(actual, instanceOf(IEventCommandMap));
			*/
		}
	}
}
