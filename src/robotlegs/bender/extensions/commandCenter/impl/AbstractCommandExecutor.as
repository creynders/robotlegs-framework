package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingList;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.framework.impl.applyHooks;
    import robotlegs.bender.framework.impl.guardsApprove;
    
    public class AbstractCommandExecutor{
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
       
        protected var _trigger:ICommandTrigger;
        
        protected var _injector:Injector;
                
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/

        public function AbstractCommandExecutor( trigger:ICommandTrigger,
                                         injector:Injector ){
            _trigger = trigger;
            _injector = injector;
        }
        
        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/
        
        protected function beforeGuarding():void
        {
        }
        
        protected function beforeHooking():void
        {
        }
        
        protected function beforeExecuting():void
        {
        }
        
        protected function whenExecuted():void
        {
        }
        
        /**
         * Constructs and executes mapped Commands
         * @param event The event that triggered this execution
         */
        protected function executeCommands( mappings : ICommandMappingIterator ):void{
            for (var mapping:ICommandMapping = mappings.first(); mapping; mapping = mappings.next() )
            {
                var command:Object = null;
                beforeGuarding();
                if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector) )
                {
                    
                    mapping.fireOnce && _trigger.removeMapping(mapping);
                    const commandClass:Class = mapping.commandClass;
                    command = _injector.instantiateUnmapped(commandClass);
                    beforeHooking();
                    if (mapping.hooks.length > 0)
                    {
                        _injector.map(commandClass).toValue(command);
                        applyHooks(mapping.hooks, _injector);
                        _injector.unmap(commandClass);
                    }
                }
                beforeExecuting();
                if (command)
                {
                    command.execute();
                    whenExecuted();
                }
            }
        }
        
    }
}