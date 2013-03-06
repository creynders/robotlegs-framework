//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
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
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;

	public class CommandMappingListTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var list:CommandMappingList;
        
        protected var mapping1:ICommandMapping;
        
        protected var mapping2:ICommandMapping;
        
        protected var mapping3:ICommandMapping;
        
        
        
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
		public function test_empty_list_has_no_head():void
		{
			assertThat(list.head, nullValue());
		}

		[Test]
		public function test_add_first_node_sets_list_head_and_tail():void
		{
			list.add(mapping1);
			assertThat(list.head, equalTo(mapping1));
			assertThat(list.tail, equalTo(mapping1));
		}

		[Test]
		public function test_add_another_keeps_old_listHead():void
		{
			list.add(mapping1);
			list.add(mapping2);
			assertThat(list.head, equalTo(mapping1));
		}

		[Test]
		public function test_add_another_sets_new_listTail():void
		{
			list.add(mapping1);
			list.add(mapping2);
			assertThat(list.tail, equalTo(mapping2));
		}

		[Test]
		public function test_add_node_sets_node_pointers():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.add(mapping3);
			assertThat(list.head, equalTo(mapping1));
			assertThat(list.tail, equalTo(mapping3));
			assertThat( list.getPrevious( mapping1 ), nullValue());
			assertThat( list.getNext( mapping1 ), equalTo(mapping2));
			assertThat( list.getPrevious( mapping2 ), equalTo(mapping1));
			assertThat( list.getNext( mapping2 ), equalTo(mapping3));
			assertThat( list.getPrevious( mapping3 ), equalTo(mapping2));
			assertThat( list.getNext( mapping3 ), nullValue());
		}

		[Test]
		public function test_remove_last_node_removes_head_and_tail():void
		{
			list.add(mapping1);
			list.remove(mapping1);
			assertThat(list.head, nullValue());
			assertThat(list.tail, nullValue());
		}

		[Test]
		public function remove_middle_node_preserves_head_and_tail():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.add(mapping3);
			list.remove(mapping2);
			assertThat(list.head, equalTo(mapping1));
			assertThat(list.tail, equalTo(mapping3));
		}

		[Test]
		public function remove_head_node_sets_new_head():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.remove(mapping1);
			assertThat(list.head, equalTo(mapping2));
			assertThat( list.getPrevious( mapping2 ), nullValue());
		}

		[Test]
		public function remove_tail_node_sets_new_tail():void
		{
			list.add(mapping1);
			list.add(mapping2);
			list.remove(mapping2);
			assertThat(list.tail, equalTo(mapping1));
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
        
        [Test]
        public function test_first_returns_first_element() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            assertThat( list.first(), equalTo( mapping1 ) );
        }
        
        [Test]
        public function test_first_rewinds_list() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            list.first();
            list.next();
            assertThat( list.first(), equalTo( mapping1 ) ); 
        }
        
        [Test]
        public function test_next_iterates_FIFO() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            list.add( mapping3 );
            const expectedOrder:Array = [ mapping1, mapping2, mapping3 ];
            var iteratedOrder : Array = [
                list.next(),
                list.next(),
                list.next()
            ];
            assertThat( expectedOrder, array( iteratedOrder ) );
        }
        
        [Test]
        public function test_next_returns_first_element_when_called_first() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            assertThat( list.next(), equalTo( mapping1 ) );
        }
        
        [Test]
        public function test_next_does_not_loop_when_done() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            list.first();
            list.next();
            assertThat( list.next(), nullValue() );
        }
        
        [Test]
        public function test_next_returns_next_when_current_removed() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            list.add( mapping3 );
            list.first();
            var current : ICommandMapping = list.next();
            list.remove( current );
            assertThat( list.next(), equalTo( mapping3 ) );
        }
        
        [Test]
        public function test_hasNext_returns_true_when_items_in_queue() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            assertThat( list.hasNext(), equalTo( true ) );
        }
        
        [Test]
        public function test_hasNext_returns_true_when_not_done() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            list.first();
            assertThat( list.hasNext(), equalTo( true ) );
        }
        
        [Test]
        public function test_hasNext_returns_false_when_at_end() : void{
            list.add( mapping1 );
            list.add( mapping2 );
            list.add( mapping3 );
            list.first();
            list.next();
            list.next();
            assertThat( list.hasNext(), equalTo( false ) );
        }
        
	}
}
