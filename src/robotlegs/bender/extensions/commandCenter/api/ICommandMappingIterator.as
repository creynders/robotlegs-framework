package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMappingIterator{
        
        /**
         * TODO: document
         */
        function first() : ICommandMapping;
        
        /**
         * TODO: document
         */
        function next() : ICommandMapping;
        
        /**
         * TODO: document
         */
        function hasNext() : Boolean;
        
    }
}