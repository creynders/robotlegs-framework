package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMappingCollection{
        
        /**
         * TODO: document
         */
        function add( mapping:ICommandMapping):void;
        
        /**
         * TODO: document
         */
        function remove( mapping:ICommandMapping):void;
        
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