package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.framework.impl.applyHooks;
    import robotlegs.bender.framework.impl.guardsApprove;
    
    /**
     * 
     * @author creynder
     * 
     */
    public class AbstractCommandExecutor{
        
        /*============================================================================*/
        /* Protected Properties                                                       */
        /*============================================================================*/
       
        protected var _trigger:ICommandTrigger;
        
        protected var _injector:Injector;
                
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/

        /**
         * @private
         */
        public function AbstractCommandExecutor( trigger:ICommandTrigger,
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
        public function executeCommands( mappings : ICommandMappingCollection ):Boolean{
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
        
       /*============================================================================*/
        /* Protected Functions                                                        */
        /*============================================================================*/
        
        /**
         * @inheritDoc
         */
        protected function beforeGuarding():void
        {
        }
        
        /**
         * @inheritDoc
         */
        protected function beforeHooking():void
        {
        }
        
        /**
         * @inheritDoc
         */
        protected function beforeExecuting():void
        {
        }
        
        /**
         * @inheritDoc
         */
        protected function whenExecuted():void
        {
        }
        
        
    }
}