package robotlegs.bender.rewrite.priorityEventCommandMap.api
{
    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMappingConfig{
        function withGuards(... guards):IPriorityEventCommandMappingConfig;
        function withHooks(... hooks):IPriorityEventCommandMappingConfig;
        function once(value:Boolean = true):IPriorityEventCommandMappingConfig;
        function withPriority( priority : int = 0 ) : IPriorityEventCommandMappingConfig;
    }
}