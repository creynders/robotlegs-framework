package robotlegs.bender.extensions.commandCenter.api
{
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;

    /**
     * @author creynder
     */
    public interface ICommandMappingFactory{
        /**
         * TODO: document
         */
        function createMapping( commandClass : Class ) : ICommandMapping;
    }
}