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
	import org.hamcrest.object.nullValue;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;

	public class CommandMappingListTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var list:CommandMappingList;

		private var mapping1:ICommandMapping;

		private var mapping2:ICommandMapping;

		private var mapping3:ICommandMapping;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			list = new CommandMappingList();
			mapping1 = new CommandMapping(NullCommand);
			mapping2 = new CommandMapping(NullCommand);
			mapping3 = new CommandMapping(NullCommand);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function empty_list_has_no_head():void
		{
			assertThat(list.headNode, nullValue());
		}

		[Test]
		public function add_first_node_sets_list_head_and_tail():void
		{
			list.add(mapping1);
			assertThat(list.getHead(), equalTo(mapping1));
			assertThat(list.getTail(), equalTo(mapping1));
		}

		[Test]
		public function add_another_keeps_old_listHead():void
		{
			list.add(mapping1);
			list.add(mapping2);
			assertThat(list.getHead(), equalTo(mapping1));
		}

		[Test]
		public function add_another_sets_new_listTail():void
		{
			list.add(mapping1);
			list.add(mapping2);
			assertThat(list.getTail(), equalTo(mapping2));
		}

		[Test]
		public function add_node_sets_node_pointers():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.add(mapping3);
			assertThat(list.getHead(), equalTo(mapping1));
			assertThat(list.getTail(), equalTo(mapping3));
			assertThat( list.getPrevious( mapping1 ), nullValue());
			assertThat( list.getNext( mapping1 ), equalTo(mapping2));
			assertThat( list.getPrevious( mapping2 ), equalTo(mapping1));
			assertThat( list.getNext( mapping2 ), equalTo(mapping3));
			assertThat( list.getPrevious( mapping3 ), equalTo(mapping2));
			assertThat( list.getNext( mapping3 ), nullValue());
		}

		[Test]
		public function remove_last_node_removes_head_and_tail():void
		{
			list.add(mapping1);
			list.remove(mapping1);
			assertThat(list.getHead(), nullValue());
			assertThat(list.getTail(), nullValue());
		}

		[Test]
		public function remove_middle_node_preserves_head_and_tail():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.add(mapping3);
			list.remove(mapping2);
			assertThat(list.getHead(), equalTo(mapping1));
			assertThat(list.getTail(), equalTo(mapping3));
		}

		[Test]
		public function remove_head_node_sets_new_head():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.remove(mapping1);
			assertThat(list.getHead(), equalTo(mapping2));
			assertThat( list.getPrevious( mapping2 ), nullValue());
		}

		[Test]
		public function remove_tail_node_sets_new_tail():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.remove(mapping2);
			assertThat(list.getTail(), equalTo(mapping1));
			assertThat( list.getNext( mapping1 ), nullValue());
		}

		[Test]
		public function remove_middle_node_stitches_siblings_together():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.add(mapping3);
			list.remove(mapping2);
			assertThat( list.getNext( mapping1 ), equalTo(mapping3));
			assertThat( list.getPrevious( mapping3 ), equalTo(mapping1));
		}
	}
}
