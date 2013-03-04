package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMappingIterator{
        
        /**
         * TODO: document
         */
        function get isDone() : Boolean;
        
        /**
         * TODO: document
         */
        function get currentMapping() : ICommandMapping;
        
        /**
         * TODO: document
         */
        function first() : ICommandMapping;
        
        /**
         * TODO: document
         */
        function next() : ICommandMapping;
        
    }
}