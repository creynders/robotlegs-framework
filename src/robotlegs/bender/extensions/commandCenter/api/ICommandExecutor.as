package robotlegs.bender.extensions.commandCenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandExecutor{
        function beforeGuarding( callback : Function ) : void;
        function beforeHooking( callback : Function ) : void;
        function beforeExecuting( callback : Function ) : void;
        function afterExecuting( callback : Function ) : void;
        function execute() : void;
    }
}