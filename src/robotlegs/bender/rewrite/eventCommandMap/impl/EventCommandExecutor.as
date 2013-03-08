package robotlegs.bender.rewrite.eventCommandMap.impl
{
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.rewrite.commandcenter.api.ICommandExecutor;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;

    /**
     * @author creynder
     */
    
    //extends AbstractCommandExecutor
    public class EventCommandExecutor implements ICommandExecutor{
        public function EventCommandExecutor(			trigger:ICommandTrigger,
                                                        injector:Injector,
                                                        eventClass:Class)

        {
        }
    }
}