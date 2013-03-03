package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMappingList{
        function get head() : ICommandMapping;
        function get tail() : ICommandMapping;
        function add(node:ICommandMapping):void;
        function remove(node:ICommandMapping):void;
    }
}