package robotlegs.bender.rewrite.priorityEventCommandMap.impl
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;
    
    public class PriorityEventCommandExecutor implements ICommandExecutor{
        public function PriorityEventCommandExecutor(			trigger:ICommandTrigger,
                                                                injector:Injector,
                                                                eventClass:Class)

        {
        }
        
        public function beforeGuarding():void
        {
        }
        
        public function beforeHooking():void
        {
        }
        
        public function beforeExecuting():void
        {
        }
        
        public function whenExecuted():void
        {
        }
        
        public function executeCommands(mappings:ICommandMappingIterator):Boolean
        {
            return false;
        }
        
        public function executeCommand(command:Object):Boolean
        {
            return false;
        }
    }
}