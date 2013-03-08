package robotlegs.bender.rewrite.priorityEventCommandMap.impl
{
    /**
     * @author creynder
     */
    import flash.utils.Dictionary;
    
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.rewrite.commandcenter.api.ICommandCenter;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandExecutor;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;
    import robotlegs.bender.rewrite.eventCommandMap.impl.EventCommandMap;
    import robotlegs.bender.rewrite.eventCommandMap.impl.EventCommandTrigger;
    import robotlegs.bender.rewrite.priorityEventCommandMap.api.IPriorityEventCommandMap;
    import robotlegs.bender.rewrite.priorityEventCommandMap.api.IPriorityEventCommandMapper;
    
    public class PriorityEventCommandMap implements IPriorityEventCommandMap{
        public function PriorityEventCommandMap( injector : Injector )
        {
            _injector = injector;
            
            _ecm = new EventCommandMap( injector );
        }
        
        private var _injector : Injector;
        
        private const _triggers:Dictionary = new Dictionary();
        private var _commandCenter:ICommandCenter;
        
       
       private var _ecm : EventCommandMap
        
        public function map(type:String, eventClass:Class = null):IPriorityEventCommandMapper{
            const trigger:EventCommandTrigger =
                _triggers[type + eventClass] ||=
                createTrigger(type, eventClass);
            _commandCenter.map( trigger );
            return ( createBuilder( trigger ) as PriorityEventCommandMapper );
        }
        
        protected function createBuilder( trigger : ICommandTrigger ):PriorityEventCommandMapper
        {
            return new PriorityEventCommandMapper( trigger );
        }
        
        private function createTrigger(type:String, eventClass:Class = null):ICommandTrigger
        {
            return new EventCommandTrigger(type, eventClass);
        }
        
        protected function createExecutor( trigger : ICommandTrigger, eventClass : Class ) : ICommandExecutor{
            return new PriorityEventCommandExecutor( trigger, _injector, eventClass );
        }
        
    }
}