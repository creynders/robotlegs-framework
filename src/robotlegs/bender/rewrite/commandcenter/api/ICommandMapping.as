package robotlegs.bender.rewrite.commandcenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMapping{
        function get commandClass():Class;
        /**
         * A list of Guards to query before execution
         */
        function get guards():Array;
        
        /**
         * A list of Hooks to run during execution
         */
        function get hooks():Array;
        
        /**
         * Unmaps a Command after a successful execution
         */
        function get fireOnce():Boolean;
    }
}