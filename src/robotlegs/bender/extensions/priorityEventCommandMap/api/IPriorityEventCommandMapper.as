package robotlegs.bender.extensions.priorityEventCommandMap.api
{
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
    import robotlegs.bender.extensions.priorityEventCommandMap.impl.PriorityEventCommandMapper;

    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMapper {
        function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig;
    }
}