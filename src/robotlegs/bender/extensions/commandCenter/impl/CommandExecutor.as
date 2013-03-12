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
        public function executeCommands( mappings : ICommandMappingCollection ):Boolean{
            for (var mapping:ICommandMapping = mappings.first(); mapping; mapping = mappings.next() )
            {
                executeCommand( mapping );
            }
        }
        
        /**
         * @inheritDoc
         */
        public function executeCommand( mapping : ICommandMapping ) : void{
            var command:Object = null;
            mapPayload();
            if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector) )
            {
                
                mapping.fireOnce && _trigger.removeMapping(mapping);
                const commandClass:Class = mapping.commandClass;
                command = _injector.instantiateUnmapped(commandClass);
                if (mapping.hooks.length > 0)
                {
                    _injector.map(commandClass).toValue(command);
                    applyHooks(mapping.hooks, _injector);
                    _injector.unmap(commandClass);
                }
            }
            unmapPayload();
            if (command)
            {
                command.execute();
                whenCommandExecuted();
            }
        }
        
       /*============================================================================*/
        /* Protected Functions                                                        */
        /*============================================================================*/
        
        /**
         * TODO: document
         */
        protected function mapPayload():void
        {
        }
        
        /**
         * TODO: document
         */
        protected function unmapPayload():void
        {
        }
        
        /**
         * TODO: document
         */
        protected function whenCommandExecuted():void
        {
        }
        
        
    }
}
