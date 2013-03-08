package robotlegs.bender.rewrite.commandcenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandTrigger{
        function addMapping(mapping:ICommandMapping):void;
        function removeMapping(mapping:ICommandMapping):void;        
    }
}