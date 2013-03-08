package robotlegs.bender.rewrite.eventCommandMap.impl
{
    import flash.utils.Dictionary;
    
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.rewrite.commandcenter.api.ICommandCenter;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandExecutor;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;
    import robotlegs.bender.rewrite.commandcenter.impl.CommandMapper;
    import robotlegs.bender.rewrite.eventCommandMap.api.IEventCommandMap;

    /**
     * @author creynder
     */
    public class EventCommandMap implements IEventCommandMap{
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
        
        private const _triggers:Dictionary = new Dictionary();
        
        
        private var _commandCenter:ICommandCenter;
        private var _injector : Injector;
        
        public function EventCommandMap( injector : Injector )
        {
            _injector = injector;
        }
        
        public function map(type:String, eventClass:Class = null):ICommandMapper
        {
            const trigger:EventCommandTrigger =
                _triggers[type + eventClass] ||=
                createTrigger(type, eventClass);
            _commandCenter.map( trigger );
            return createBuilder( trigger );
        }
        
        protected function createBuilder( trigger : ICommandTrigger ):ICommandMapper
        {
            return new CommandMapper( trigger );
        }
        
        protected function createTrigger(type:String, eventClass:Class = null):ICommandTrigger
        {
            var trigger : EventCommandTrigger = new EventCommandTrigger( type, eventClass );
            trigger.executor = createExecutor( trigger, eventClass );
            return trigger;
        }
        
        protected function createExecutor( trigger : ICommandTrigger, eventClass : Class ) : ICommandExecutor{
            return new EventCommandExecutor( trigger, _injector, eventClass );
        }
        
    }
}