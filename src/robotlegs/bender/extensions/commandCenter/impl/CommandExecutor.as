package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMappingList;
    import robotlegs.bender.framework.impl.applyHooks;
    import robotlegs.bender.framework.impl.guardsApprove;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
    
    public class CommandExecutor implements ICommandExecutor{
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
       
        private var _trigger:ICommandTrigger;
        
        private var _mappings:CommandMappingList;
        
        private var _injector:Injector;
        
        private var _afterExecution : Function;
        
        private var _beforeExecution : Function;
        
        private var _beforeGuards : Function;
        
        private var _beforeHooks : Function;
        
        
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/

        public function CommandExecutor( trigger:ICommandTrigger,
                                         mappings:CommandMappingList, 
                                         injector:Injector ){
            _trigger = trigger;
            _mappings = mappings;
            _injector = injector;
        }
        
        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/
        
        public function afterExecuting(callback:Function):void
        {
            _afterExecution = callback;
        }
        
        public function beforeExecuting(callback:Function):void
        {
            _beforeExecution = callback;
        }
        
        public function beforeGuarding(callback:Function):void
        {
            _beforeGuards = callback;   
        }
        
        public function beforeHooking(callback:Function):void
        {
            _beforeHooks = callback;    
        }
        
        
        /**
         * Constructs and executes mapped Commands
         * @param event The event that triggered this execution
         */
        public function execute():void{
            for (var mapping:ICommandMapping = _mappings.head; mapping; mapping = mapping.next)
            {
                var command:Object = null;
                _beforeGuards && _beforeGuards();
                if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector) )
                {
                    
                    const commandClass:Class = mapping.commandClass;
                    command = _injector.instantiateUnmapped(commandClass);
                    _beforeHooks && _beforeHooks();
                    if (mapping.hooks.length > 0)
                    {
                        _injector.map(commandClass).toValue(command);
                        applyHooks(mapping.hooks, _injector);
                        _injector.unmap(commandClass);
                    }
                }
                _beforeExecution && _beforeExecution();
                if (command)
                {
                    mapping.fireOnce && _trigger.removeMapping(mapping);
                    command.execute();
                    _afterExecution && _afterExecution();
                }
            }
        }
        
    }
}