package robotlegs.bender.extensions.messageCommandMap.impl
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.AbstractCommandExecutor;
    import robotlegs.bender.framework.impl.safelyCallBack;
    
    public class MessageCommandExecutor extends AbstractCommandExecutor{
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
        
        private var _message : Object;
        private var _callback : Function;
        private var _mappings : ICommandMappingIterator;
        
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/
        
        /**
         * @private
         */  
        public function MessageCommandExecutor(trigger:ICommandTrigger, injector:Injector)
        {
            super(trigger, injector);
        }
        
        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/
        
        /**
         * TODO: document
         */
        public function execute( mappings : ICommandMappingIterator, message : Object, callback : Function ) : void{
            _mappings = mappings;
            _message = message;
            _callback = callback;
            
            var wasSynced : Boolean = executeCommands( mappings );
            
            if( wasSynced ){
                // If we got here then this loop finished synchronously.
                // Nobody broke out, so we are done.
                // This relies on the various return statements above. Be careful.
                _callback && safelyCallBack(_callback, null, _message);
            }
        }
        
        /*============================================================================*/
        /* Protected Functions                                                        */
        /*============================================================================*/
        
        /**
         * @inheritDoc
         */ 
        override protected function executeCommand(command:Object):Boolean
        {
            var handler : Function = command.execute;
            if (handler.length == 0) // sync handler: ()
            {
                handler();
            }
            else if (handler.length == 1) // sync handler: (message)
            {
                handler(_message);
            }
            else if (handler.length == 2) // sync or async handler: (message, callback)
            {
                var handled:Boolean;
                handler(_message, function(error:Object = null, msg:Object = null):void
                {
                    // handler must not invoke the callback more than once 
                    if (handled)
                        return;
                    
                    handled = true;
                    
                    if (error || _mappings.isDone )
                    {
                        _callback && safelyCallBack( _callback, error, _message);
                    }
                    else
                    {
                        execute( _mappings, _message, _callback);
                    }
                });
                // IMPORTANT: MUST break this loop with a RETURN. See above.
                return false;
            }
            else // ERROR: this should NEVER happen
            {
                // we swallow this and let the message processing continue
            }
            
            return true;
        }
        
    }
}