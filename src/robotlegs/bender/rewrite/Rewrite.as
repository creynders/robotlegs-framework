package robotlegs.bender.rewrite
{
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.rewrite.commandcenter.api.ICommandCenter;
    import robotlegs.bender.rewrite.commandcenter.impl.CommandCenter;
    import robotlegs.bender.rewrite.eventCommandMap.api.IEventCommandMap;
    import robotlegs.bender.rewrite.eventCommandMap.impl.EventCommandMap;
    import robotlegs.bender.rewrite.priorityEventCommandMap.api.IPriorityEventCommandMap;
    import robotlegs.bender.rewrite.priorityEventCommandMap.impl.PriorityEventCommandMap;

    /**
     * @author creynder
     */
    public class Rewrite{
        public function Rewrite()
        {
            var injector : Injector = new Injector();
            var commandCenter : ICommandCenter = new CommandCenter();
            var eventCommandMap : IEventCommandMap = new EventCommandMap( injector );
            eventCommandMap.map( 'foo' )
                .toCommand( CommandA )
                .withGuards( HappyGuard )
                .withHooks( HookA );
            var pecm : IPriorityEventCommandMap = new PriorityEventCommandMap( injector );
            pecm.map( 'foo' )
                .toCommand( CommandA )
                .withGuards( HappyGuard )
                .withHooks( HookA )
                .withPriority( 10 );
                
                
        }
    }
}

internal class CommandA{}
internal class HappyGuard{}
internal class HookA{}