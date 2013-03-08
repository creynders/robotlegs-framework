package robotlegs.bender.rewrite.priorityEventCommandMap.api
{
    import robotlegs.bender.rewrite.priorityEventCommandMap.impl.PriorityEventCommandMapper;

    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMapper{
        function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig;
    }
}