//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import mockolate.arg;
	import mockolate.expect;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.core.anything;
	import org.hamcrest.object.instanceOf;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand;
	import robotlegs.bender.extensions.commandCenter.support.NullCommand2;
	import robotlegs.bender.framework.api.ILogger;

	public class CommandMapperTest
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Rule]
		public var mocks:MockolateRule = new MockolateRule();

		[Mock]
		public var trigger:ICommandTrigger;

		[Mock]
		public var logger:ILogger;
        
        [Mock]
        public var componentFactory : ICommandMappingFactory;

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var mapper:CommandMappingBuilder;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			mapper = new CommandMappingBuilder(trigger, componentFactory, logger);
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_toCommand_registers_mappingConfig_with_trigger():void
		{
            const mapping : ICommandMapping = new CommandMapping( NullCommand );
            expect( componentFactory.createMapping( NullCommand ) ).returns( mapping );
            mapper.toCommand( NullCommand );
			assertThat(trigger, received().method('addMapping').arg(mapping).once());
		}

		[Test]
		public function test_fromCommand_passes_retrieved_mapping_to_trigger_for_removal():void
		{
            const mapping : ICommandMapping = new CommandMapping( NullCommand );
            expect( trigger.getMappingFor( arg( NullCommand ) ) ).returns( mapping );
			mapper.fromCommand(NullCommand);
			assertThat(trigger, received().method('removeMapping').arg(mapping).once());
		}

		[Test]
		public function test_fromAll_removes_all_mappingConfigs_from_trigger():void
		{
			const mapping1:ICommandMapping = new CommandMapping( NullCommand );
			const mapping2:ICommandMapping = new CommandMapping( NullCommand2 );
            var list : CommandMappingList = new CommandMappingList();
            list.add( mapping1 );
            list.add( mapping2 );
            expect( trigger.getMappings() ).returns( list ); 
			mapper.fromAll();
			assertThat(trigger, received().method('removeMapping').arg(mapping1).once());
			assertThat(trigger, received().method('removeMapping').arg(mapping2).once());
		}

		[Test]
		public function test_toCommand_unregisters_old_mappingConfig_and_registers_new_one_when_overwritten():void
		{
            const mapping1 : ICommandMapping = new CommandMapping( NullCommand );
            const mapping2 : ICommandMapping = new CommandMapping( NullCommand );
            expect( trigger.getMappingFor( NullCommand ) ).returns( mapping1 );
            expect( componentFactory.createMapping( NullCommand ) ).returns( mapping2 );
			mapper.toCommand(NullCommand);
			assertThat(trigger, received().method('removeMapping').arg(mapping1).once());
			assertThat(trigger, received().method('addMapping').arg(mapping2).once());
		}

		[Test]
		public function test_toCommand_warns_when_overwritten():void
		{
            const mapping : ICommandMapping = new CommandMapping( NullCommand );
            expect( trigger.getMappingFor( NullCommand ) ).returns( mapping );
			mapper.toCommand(NullCommand);
			assertThat(logger, received().method('warn')
				.args(instanceOf(String), array(trigger, mapping)).once());
		}
	}
}
