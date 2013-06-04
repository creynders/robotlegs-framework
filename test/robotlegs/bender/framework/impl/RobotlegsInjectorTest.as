//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.framework.impl
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	import org.swiftsuspenders.dependencyproviders.SingletonProvider;

	/**
	 * Majority of tests to be found under org.swiftsuspenders.InjectorTests
	 *
	 * This class only tests added/modified functionalities
	 */
	public class RobotlegsInjectorTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:RobotlegsInjector;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			subject = new RobotlegsInjector();
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function retrieves_provider_for_existing_mapping():void
		{
			subject.map(NullInterface).toSingleton(NullClass);
			assertThat(subject.getProviderFor(NullInterface), instanceOf(SingletonProvider));
		}
	}
}

internal interface NullInterface
{
}

internal class NullClass
{
}
