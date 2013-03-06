package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.framework.impl.applyHooks;
    import robotlegs.bender.framework.impl.guardsApprove;
    
    public class CommandExecutor implements ICommandExecutor{
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
       
        protected var _trigger:ICommandTrigger;
        
        protected var _injector:Injector;
                
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/

        public function CommandExecutor( trigger:ICommandTrigger,
                                         injector:Injector ){
            _trigger = trigger;
            _injector = injector;
        }
        
        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/
        
        /**
         * @inheritDoc
         */
        public function beforeGuarding():void
        {
        }
        
        /**
         * @inheritDoc
         */
        public function beforeHooking():void
        {
        }
        
        /**
         * @inheritDoc
         */
        public function beforeExecuting():void
        {
        }
        
        /**
         * @inheritDoc
         */
        public function whenExecuted():void
        {
        }
        
        /**
         * @inheritDoc
         */
        public function executeCommands( mappings : ICommandMappingIterator ):Boolean{
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
                    var isSynced : Boolean = executeCommand( command );
                    whenExecuted();
                    if( ! isSynced ){
                        return false;
                    }
                }
            }
            
            return true;
        }
        
        /**
         * @inheritDoc
         */
        public function executeCommand( command : Object ) : Boolean{
            command.execute();
            return true;
        }
        
    }
}