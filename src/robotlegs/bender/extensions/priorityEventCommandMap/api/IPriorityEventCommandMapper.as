package robotlegs.bender.extensions.priorityEventCommandMap.api
{
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingBuilder;
    import robotlegs.bender.extensions.priorityEventCommandMap.impl.PriorityEventCommandMapper;

    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMapper {
        function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig;
    }
}