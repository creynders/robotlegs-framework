package robotlegs.bender.extensions.commandCenter.support
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.CommandExecutor;
    
    public class CallbackCommandExecutor extends CommandExecutor{
        public function CallbackCommandExecutor(trigger:ICommandTrigger, injector:Injector)
        {
            super(trigger, injector);
        }
        
        public var beforeExecutingCallback : Function;
        public var beforeGuardingCallback : Function;
        public var beforeHookingCallback : Function;
        public var whenExecutedCallback : Function;
        
        public function execute() : void{
            executeCommands( _trigger.getMappings() );
        }
        
        override public function beforeExecuting():void
        {
            beforeExecutingCallback && beforeExecutingCallback();
        }
        
        override public function beforeGuarding():void
        {
            beforeGuardingCallback && beforeGuardingCallback();
        }
        
        override public function beforeHooking():void
        {
            beforeHookingCallback && beforeHookingCallback();
        }
        
        override public function whenExecuted():void
        {
            whenExecutedCallback && whenExecutedCallback();
        }
        
        
    }
}