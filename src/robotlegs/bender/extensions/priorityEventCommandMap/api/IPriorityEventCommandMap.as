package robotlegs.bender.extensions.priorityEventCommandMap.api
{
    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMap{
        function map(type:String, eventClass:Class = null):IPriorityEventCommandMappingBuilder;
    }
}