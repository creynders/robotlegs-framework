package robotlegs.bender.extensions.eventCommandMap.impl
{
    import flash.events.Event;
    import flash.utils.getTimer;
    
    import mockolate.runner.MockolateRule;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMappingList;

    /**
     * @author creynder
     */
    public class EventCommandExecutorStressTest{
        public function EventCommandExecutorStressTest()
        {
        }
        
        private var injector : Injector;
        private var mappings : CommandMappingList;
        private var executor:EventCommandExecutor;
        
        [Rule]
        public var mockolateRule : MockolateRule = new MockolateRule();
        
        [Mock]
        public var trigger : ICommandTrigger;
        
        [Before]
        public function setup():void{
            mappings = new CommandMappingList();
            executor = new EventCommandExecutor(
                trigger,
                mappings,
                new Injector(),
                Event
            );
        }
        
        [After]
        public function teardown():void{
        }
        
        [Test]
        public function test_self():void{
            assertThat( true, equalTo( true ) );
        }
        
        [Test]
        public function test_command_execution_speed_test() : void{
            createCommandMappingsList( CommandA, 100000 ); 
            var start : int = getTimer();
            executor.execute( new Event( 'event' ) );
            var took : int = getTimer() - start;
            trace( 'test_command_execution_speed_test', took );//2012-02-26: 2912, 2854, 2759, 2702
        }
        
        private function createCommandMappingsList( commandClass : Class, n : int = 1 ) : void{
            var i : int;
            for ( i = 0; i<n; i++ ){
                var mapping : ICommandMapping = new CommandMapping( commandClass );
                mappings.add( mapping );
            }
        }
        
        
        
    }
}

internal class CommandA{
    public function execute() : void{
        
    }
}