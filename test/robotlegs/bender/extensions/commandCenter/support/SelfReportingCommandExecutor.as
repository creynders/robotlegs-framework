package robotlegs.bender.extensions.commandCenter.support
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.AbstractCommandExecutor;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMappingList;
    
    public class SelfReportingCommandExecutor extends AbstractCommandExecutor{
        public function SelfReportingCommandExecutor(trigger:ICommandTrigger, mappings:CommandMappingList, injector:Injector)
        {
            super(trigger, injector);
        }
        
        public var beforeExecutingCallback : Function;
        public var beforeGuardingCallback : Function;
        public var beforeHookingCallback : Function;
        public var whenExecutedCallback : Function;
        
        public function execute() : void{
            executeCommands();
        }
        
        override protected function beforeExecuting():void
        {
            beforeExecutingCallback && beforeExecutingCallback();
        }
        
        override protected function beforeGuarding():void
        {
            beforeGuardingCallback && beforeGuardingCallback();
        }
        
        override protected function beforeHooking():void
        {
            beforeHookingCallback && beforeHookingCallback();
        }
        
        override protected function whenExecuted():void
        {
            whenExecutedCallback && whenExecutedCallback();
        }
        
        
    }
}