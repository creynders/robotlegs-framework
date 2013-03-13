package robotlegs.bender.extensions.priorityEventCommandMap.api
{
    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMappingConfig{
        function withGuards(... guards):IPriorityEventCommandMappingConfig;
        function withHooks(... hooks):IPriorityEventCommandMappingConfig;
        function withPriority( priority : int = 0 ) : IPriorityEventCommandMappingConfig;
    }
}