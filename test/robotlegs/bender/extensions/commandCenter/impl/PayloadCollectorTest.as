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

	import robotlegs.bender.extensions.commandCenter.support.PayloadCarrierObject;

	public class PayloadCollectorTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:PayloadCollector;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			subject = new PayloadCollector();
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function collects_payload():void
		{
			const p1 : String = 'payload';
			const p2 : Object = {};
			var payload : CommandPayload = subject.collectPayload( new PayloadCarrierObject( p1, p2 ) );
			assertThat( payload.values, array( p1, p2 ));
		}
	}
}
