package robotlegs.bender.rewrite.eventCommandMap.api
{
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;

    /**
     * @author creynder
     */
    public interface IEventCommandMap{
        function map(type:String, eventClass:Class = null):ICommandMapper;
    }
}