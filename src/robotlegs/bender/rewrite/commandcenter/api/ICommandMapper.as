package robotlegs.bender.rewrite.commandcenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMapper{
        /**
         * Creates a command mapping
         * @param commandClass The Command Class to map
         * @return Mapping configurator
         */
        function toCommand(commandClass:Class):ICommandMappingConfig;
        
    }
}