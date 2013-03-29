//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandTriggerMap;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.support.SupportEvent;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	public class EventCommandMapTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var eventCommandMap:IEventCommandMap;

		private var mapper:ICommandMapper;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			var context:IContext = new Context();
			eventCommandMap = new EventCommandMap(context, new EventDispatcher());
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_map_creates_mapper():void
		{
			assertThat(eventCommandMap.map(SupportEvent.TYPE1, SupportEvent), instanceOf(ICommandMapper));
		}

		[Test]
		public function test_map_returns_new_mapper_when_identical_type_and_event():void
		{
			mapper = eventCommandMap.map(SupportEvent.TYPE1, SupportEvent);
			assertThat(eventCommandMap.map(SupportEvent.TYPE1, SupportEvent), not(equalTo(mapper)));
		}

		[Test]
		public function test_map_to_identical_Type_but_different_Event_returns_different_mapper():void
		{
			mapper = eventCommandMap.map(SupportEvent.TYPE1, SupportEvent);
			assertThat(eventCommandMap.map(SupportEvent.TYPE1, Event), not(equalTo(mapper)));
		}

		[Test]
		public function test_map_to_different_Type_but_identical_Event_returns_different_mapper():void
		{
			mapper = eventCommandMap.map(SupportEvent.TYPE1, SupportEvent);
			assertThat(eventCommandMap.map(SupportEvent.TYPE2, SupportEvent), not(equalTo(mapper)));
		}

		[Test]
		public function test_unmap_returns_unmapper():void
		{
			mapper = eventCommandMap.map(SupportEvent.TYPE1, SupportEvent);
			assertThat(mapper, instanceOf(ICommandUnmapper));
		}

		[Test]
		public function test_robust_to_unmapping_non_existent_mappings():void
		{
			eventCommandMap.unmap(SupportEvent.TYPE1).fromCommand(NullCommand);
		}
	}
}
