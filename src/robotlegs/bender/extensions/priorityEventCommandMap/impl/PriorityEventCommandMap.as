package robotlegs.bender.extensions.priorityEventCommandMap.impl
{
    /**
     * @author creynder
     */
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.eventCommandMap.impl.EventCommandMap;
    import robotlegs.bender.extensions.eventCommandMap.impl.EventCommandTrigger;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMap;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMapper;
    
    
    public class PriorityEventCommandMap implements IPriorityEventCommandMap, ICommandMappingFactory{
        public function PriorityEventCommandMap( injector : Injector, dispatcher : IEventDispatcher, commandCenter : ICommandCenter )
        {
            _injector = injector;
            _dispatcher = dispatcher;
            
            _ecm = new EventCommandMap( injector, dispatcher, commandCenter );
        }
        
        private var _injector : Injector;
        
        private const _triggers:Dictionary = new Dictionary();
        private var _commandCenter:ICommandCenter;
        
       
        private var _ecm : EventCommandMap
        
        private var _dispatcher:IEventDispatcher;
        public function map(type:String, eventClass:Class = null):IPriorityEventCommandMapper{
            var key : String = getKey( type, eventClass );
            var trigger : ICommandTrigger = _commandCenter.getTrigger( key );
            if( ! trigger ){
                trigger = createTrigger( type, eventClass );
                _commandCenter.map( trigger, key );
            }
            return createMapper( trigger );
        }
        
        private function createTrigger(type:String, eventClass:Class = null):ICommandTrigger
        {
            return new EventCommandTrigger( _injector, _dispatcher, type, eventClass);
        }
        
        private function getKey( type:String, eventClass:Class = null ) : String{
            return type + eventClass;
        }
        public function createMapper( trigger : ICommandTrigger ):IPriorityEventCommandMapper
        {
            return new PriorityEventCommandMapper( trigger, this );
        }
        
        
        public function createMapping( commandClass :Class ):ICommandMapping
        {
            return PriorityEventCommandMapping( commandClass );
        }
        
    }
}