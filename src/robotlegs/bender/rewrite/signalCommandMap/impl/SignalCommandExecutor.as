package robotlegs.bender.rewrite.signalCommandMap.impl
{
    /**
     * @author creynder
     */
    import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    import robotlegs.bender.extensions.commandCenter.impl.AbstractCommandExecutor;
    
    public class SignalCommandExecutor extends AbstractCommandExecutor implements ICommandExecutor{
        public function SignalCommandExecutor( trigger : SignalCommandTrigger, signalClass : Class )
        {
        }
        
        override protected function beforeExecuting():void
        {
        }
        
        override protected function beforeGuarding():void
        {
        }
        
        
        override public function executeCommands(mappings:ICommandMappingIterator):Boolean
        {
            return false;
        }
        
        override public function executeCommand(command:Object):Boolean
        {
            return false;
        }
    }
}