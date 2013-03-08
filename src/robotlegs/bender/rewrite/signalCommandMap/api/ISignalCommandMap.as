package robotlegs.bender.rewrite.signalCommandMap.api
{
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;

    /**
     * @author creynder
     */
    public interface ISignalCommandMap{
        function map( signalClass:Class, once:Boolean=false ):ICommandMapper;
    }
}