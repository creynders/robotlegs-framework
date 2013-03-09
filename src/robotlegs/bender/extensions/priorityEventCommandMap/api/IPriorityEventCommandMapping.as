package robotlegs.bender.extensions.priorityEventCommandMap.api
{
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;

    /**
     * @author creynder
     */
    public interface IPriorityEventCommandMapping extends ICommandMapping{
        function get priority() : int;
        function setPriority( value : int = 0 ) : IPriorityEventCommandMapping;
    }
}