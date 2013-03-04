package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMappingCollection{
        function add(node:ICommandMapping):void;
        function remove(node:ICommandMapping):void;
    }
}