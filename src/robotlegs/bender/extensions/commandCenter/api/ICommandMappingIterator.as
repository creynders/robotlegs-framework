package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMappingIterator{
        
        function get isDone() : Boolean;
        function get currentMapping() : ICommandMapping;
        
        function first() : ICommandMapping;
        function next() : ICommandMapping;
        
    }
}