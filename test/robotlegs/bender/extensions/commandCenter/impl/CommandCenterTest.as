//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.nullValue;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.support.NullCommandTrigger;

	public class CommandCenterTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var commandCenter:ICommandCenter;

		private var trigger:ICommandTrigger;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			commandCenter = new CommandCenter();
			trigger = new NullCommandTrigger();
		}

		[After]
		public function after():void
		{
			commandCenter = null;
			trigger = null;
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_map_stores_trigger():void
		{
            commandCenter.map( trigger, this );
            assertThat( commandCenter.getTrigger( this ), equalTo( trigger ) );
		}

		[Test]
		public function test_unmap_removes_trigger():void
		{
            commandCenter.map( trigger, this );
            commandCenter.unmap( this );
            assertThat( commandCenter.getTrigger( this ), nullValue() );
		}
        
        [Test]
        public function test_map_behaviour_when_key_already_used() : void{
            // TODO: determine what to do
        }
        
        [Test]
        public function test_unmap_when_key_not_found() : void{
            // TODO: determine what to do
        }

	}
}
