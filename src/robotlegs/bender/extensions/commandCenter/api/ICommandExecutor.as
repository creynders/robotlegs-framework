package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandExecutor{
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