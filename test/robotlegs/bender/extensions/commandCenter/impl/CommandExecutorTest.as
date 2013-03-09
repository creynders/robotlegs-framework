package robotlegs.bender.extensions.commandCenter.impl
{
    import mockolate.runner.MockolateRule;
    import mockolate.stub;
    import mockolate.verify;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.collection.array;
    import org.hamcrest.object.equalTo;
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;
    import robotlegs.bender.extensions.commandCenter.support.CallbackCommand;
    import robotlegs.bender.extensions.commandCenter.support.CallbackCommandExecutor;
    import robotlegs.bender.framework.impl.guardSupport.GrumpyGuard;
    import robotlegs.bender.framework.impl.guardSupport.HappyGuard;

    /**
     * @author creynder
     */
    public class CommandExecutorTest{
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
        
        private var injector:Injector;
        
        private var reportedExecutions:Array;
        
        private var mappings : CommandMappingList;
        
        [Rule]
        public var mockolateRule : MockolateRule = new MockolateRule();        
        
        [Mock]
        public var mockTrigger : ICommandTrigger;
        
        /*============================================================================*/
        /* Test Setup and Teardown                                                    */
        /*============================================================================*/
        
        [Before]
        public function before():void
        {
            mappings = new CommandMappingList();
            stub( mockTrigger ).method( 'getMappings' ).returns( mappings );
            reportedExecutions = [];
            injector = new Injector();
            injector.map( Injector ).toValue( injector );
            injector.map( ICommandTrigger ).toValue( mockTrigger );
            injector.map(Function, "reportingFunction").toValue(reportingFunction);
            injector.map( CommandMappingList ).toValue( mappings );
            injector.map( CallbackCommandExecutor ).asSingleton();
            
        }
        
        [Test]
        public function test_self() : void{
            assertThat( true, equalTo( true ) );
        }
        
        [Test]
        public function test_command_executes_successfully():void
        {
            assertThat(commandExecutionCount(1), equalTo(1));
        }
        
        [Test]
        public function test_command_executes_repeatedly():void
        {
            assertThat(commandExecutionCount(5), equalTo(5));
        }

        [Test]
        public function test_fireOnce_command_executes_calls_trigger_removeMapping():void
        {
            assertThat( commandExecutionCountFireOnce() );
            verify( mockTrigger ).method( 'removeMapping' ).once();
        }
        
        [Test]
        public function test_hooks_are_called():void{
            var hookCount : uint = 0;
            var hook : Function = function hook_callback() : void{
                hookCount++;
            };

            commandExecutionCountaddHooks( hook, hook, hook );
            assertThat( hookCount, equalTo( 3 ) );
        }        
        
        [Test]
        public function test_command_executes_when_the_guard_allows():void
        {
            assertThat(commandExecutionCountaddGuards(HappyGuard), equalTo(1));
        }
        
        [Test]
        public function test_command_executes_when_all_guards_allow():void
        {
            assertThat(commandExecutionCountaddGuards(HappyGuard, HappyGuard), equalTo(1));
        }
        
        [Test]
        public function test_command_does_not_execute_when_the_guard_denies():void
        {
            assertThat(commandExecutionCountaddGuards(GrumpyGuard), equalTo(0));
        }
        
        [Test]
        public function test_command_does_not_execute_when_all_guards_deny():void
        {
            assertThat(commandExecutionCountaddGuards(GrumpyGuard, GrumpyGuard ), equalTo(0));
        }
        
        [Test]
        public function test_command_does_not_execute_when_any_guards_denies():void
        {
            assertThat(commandExecutionCountaddGuards(HappyGuard, GrumpyGuard), equalTo(0));
        }
        
        [Test]
        public function test_execution_sequence_is_guard_command_guard_command_with_multiple_mappings():void
        {
            addMapping( CommandA ).addGuards( GuardA );
            addMapping( CommandB ).addGuards( GuardB );
            const expectedOrder:Array = [GuardA, CommandA, GuardB, CommandB];
            instantiateAndExecute();
            assertThat(reportedExecutions, array(expectedOrder));
        }
        
        [Test]
        public function test_execution_sequence_is_guard_hook_command() : void{
            addMapping( CommandA )
                .addGuards( GuardA )
                .addHooks( HookA );
            const expectedOrder : Array = [ GuardA, HookA, CommandA ];
            instantiateAndExecute();
            assertThat(reportedExecutions, array(expectedOrder));
        }
        
        [Test]
        public function test_allowed_commands_get_executed_after_denied_command() : void{
            addMapping( CommandA )
                .addGuards( GrumpyGuard )
            ;
            addMapping( CommandB );
            const expectedOrder : Array = [ CommandB ];
            instantiateAndExecute();
            assertThat(reportedExecutions, array(expectedOrder));
        }
        
        [Test]
        public function test_phases_called_in_order() : void{
            addMapping( CommandA )
                .addGuards( GuardA )
                .addHooks( HookA )
            ;
            var beforeGuarding : Function = function() : void{
                reportingFunction( beforeGuarding );
            }
            var beforeHooking : Function = function() : void{
                reportingFunction( beforeHooking );
            }
            var beforeExecuting : Function = function() : void{
                reportingFunction( beforeExecuting );
            }
            var afterExecuting : Function = function() : void{
                reportingFunction( afterExecuting );
            }
            var executor : CallbackCommandExecutor = injector.getInstance( CallbackCommandExecutor );
            executor.beforeGuardingCallback= beforeGuarding;
            executor.beforeHookingCallback= beforeHooking;
            executor.beforeExecutingCallback= beforeExecuting;
            executor.whenExecutedCallback= afterExecuting;
            executor.execute();
            const expectedOrder : Array = [ 
                beforeGuarding, 
                GuardA, 
                beforeHooking, 
                HookA, 
                beforeExecuting, 
                CommandA, 
                afterExecuting 
            ];
            assertThat(reportedExecutions, array(expectedOrder));
        }
        
        private function instantiateAndExecute():void{
            var executor : CallbackCommandExecutor = injector.getInstance( CallbackCommandExecutor );
            executor.execute();
        }
        
        private function addMapping(commandClass:Class ):ICommandMapping
        {
            
            var mapping : CommandMapping = new CommandMapping( commandClass );
            mappings.add( mapping );
            return mapping;
        }
        
        private function commandExecutionCountFireOnce( totalEvents : uint = 1 ) : uint{
            return commandExecutionCount( totalEvents, true );
        }
        
        private function commandExecutionCountaddGuards( ...guards ) : uint{
            return commandExecutionCount( 1, false, guards );
        }
        
        private function commandExecutionCountaddHooks( ...hooks ) : uint{
            return commandExecutionCount( 1, false, null, hooks );
        }
        
        private function commandExecutionCount(totalEvents:int = 1, oneShot : Boolean = false, guards : Array = null, hooks : Array = null ):uint
        {
            var executeCount:uint = 0;
            injector.map(Function, 'executeCallback').toValue(function():void
            {
                executeCount++;
            });
            while (totalEvents--)
            {
                var mapping : ICommandMapping = addMapping( CallbackCommand );
                mapping.setFireOnce( oneShot );
                guards && mapping.addGuards.apply( mapping, guards );
                hooks && mapping.addHooks.apply( mapping, hooks );
            }
            
            instantiateAndExecute();
            injector.unmap( Function, 'executeCallback' );
            return executeCount;
        }
        
        private function reportingFunction(item:Object):void
        {
            reportedExecutions.push(item);
        }
    }
}


class GuardA
{
    
    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    
    [Inject(name="reportingFunction")]
    public var reportingFunc:Function;
    
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    
    public function approve():Boolean
    {
        reportingFunc && reportingFunc(GuardA);
        return true;
    }
}

class GuardB
{
    
    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    
    [Inject(name="reportingFunction")]
    public var reportingFunc:Function;
    
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    
    public function approve():Boolean
    {
        reportingFunc && reportingFunc(GuardB);
        return true;
    }
}

class GuardC
{
    
    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    
    [Inject(name="reportingFunction")]
    public var reportingFunc:Function;
    
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    
    public function approve():Boolean
    {
        reportingFunc && reportingFunc(GuardC);
        return true;
    }
}

class HookA{
    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    
    [Inject(name="reportingFunction")]
    public var reportingFunc:Function;
    
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    
    public function hook():void
    {
        reportingFunc && reportingFunc(HookA);
    }
}

class HookB{
    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    
    [Inject(name="reportingFunction")]
    public var reportingFunc:Function;
    
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    
    public function hook():void
    {
        reportingFunc && reportingFunc(CommandA);
    }
}

class CommandA
{
    
    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    
    [Inject(name="reportingFunction")]
    public var reportingFunc:Function;
    
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    
    public function execute():void
    {
        reportingFunc && reportingFunc(CommandA);
    }
}

class CommandB
{
    
    /*============================================================================*/
    /* Public Properties                                                          */
    /*============================================================================*/
    
    [Inject(name="reportingFunction")]
    public var reportingFunc:Function;
    
    /*============================================================================*/
    /* Public Functions                                                           */
    /*============================================================================*/
    
    public function execute():void
    {
        reportingFunc && reportingFunc(CommandB);
    }
}
