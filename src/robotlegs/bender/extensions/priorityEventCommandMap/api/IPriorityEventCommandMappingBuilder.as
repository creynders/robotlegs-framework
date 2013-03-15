package robotlegs.bender.extensions.priorityEventCommandMap.api
{
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
    import robotlegs.bender.extensions.priorityEventCommandMap.impl.PriorityEventCommandMappingBuilder;

    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMappingBuilder {
        function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig;
    }
}