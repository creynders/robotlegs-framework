package robotlegs.bender.rewrite.priorityEventCommandMap.api
{
    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMap{
        function map(type:String, eventClass:Class = null):IPriorityEventCommandMapper;
    }
}