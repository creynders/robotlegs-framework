package robotlegs.bender.extensions.commandCenter.api
{
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;

    /**
     * @author creynder
     */
    public interface ICommandMappingFactory{
        function createMapping( commandClass : Class ) : ICommandMapping;
    }
}