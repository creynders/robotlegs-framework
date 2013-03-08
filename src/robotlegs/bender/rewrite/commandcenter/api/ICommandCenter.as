package robotlegs.bender.rewrite.commandcenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandCenter{
        function map(trigger:ICommandTrigger):void;
        function unmap(trigger:ICommandTrigger):void;
    }
}