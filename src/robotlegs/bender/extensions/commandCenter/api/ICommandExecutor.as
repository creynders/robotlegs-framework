package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandExecutor{
        /**
         * TODO: document
         */
        function beforeGuarding():void;
        
        /**
         * TODO: document
         */
        function beforeHooking():void;

        /**
         * TODO: document
         */
        function beforeExecuting():void;
        
        /**
         * TODO: document
         */
        function whenExecuted():void;
        
        /**
         * TODO: document
         */
        function executeCommands( mappings : ICommandMappingIterator ):Boolean;
        
        /**
         * TODO: document
         */
        function executeCommand( command : Object ) : Boolean;
    }
}