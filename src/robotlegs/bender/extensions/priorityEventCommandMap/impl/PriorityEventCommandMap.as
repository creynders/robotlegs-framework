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
    import robotlegs.bender.extensions.commandCenter.impl.CommandCenter;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
    import robotlegs.bender.extensions.eventCommandMap.impl.EventCommandMap;
    import robotlegs.bender.extensions.eventCommandMap.impl.EventCommandTrigger;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMap;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMappingBuilder;


    public class PriorityEventCommandMap implements IPriorityEventCommandMap, ICommandMappingFactory{

        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/

        private var _injector : Injector;

        private const _triggers:Dictionary = new Dictionary();

        private var _commandCenter:ICommandCenter;

        private var _dispatcher:IEventDispatcher;

        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/

        public function PriorityEventCommandMap( injector : Injector, dispatcher : IEventDispatcher, commandCenter : ICommandCenter )
        {
            _injector = injector;
            _dispatcher = dispatcher;
            _commandCenter = commandCenter;
        }

        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/

        public function map(type:String, eventClass:Class = null):IPriorityEventCommandMappingBuilder{
			var key:String = getKey(type, eventClass);
			var trigger:ICommandTrigger = _commandCenter.getTrigger(key);
			if (!trigger)
			{
				trigger = createTrigger(type, eventClass);
				_commandCenter.map(trigger, key);
			}
			var mapper : CommandMapper = createMapper( trigger );
			return createBuilder(mapper);
        }

        public function createMapping( commandClass :Class ):ICommandMapping
        {
            return PriorityEventCommandMapping( commandClass );
        }

        /*============================================================================*/
        /* Private Functions                                                          */
        /*============================================================================*/

        private function createTrigger(type:String, eventClass:Class = null):PriorityEventCommandTrigger
        {
            return new PriorityEventCommandTrigger( _injector, _dispatcher, type, eventClass);
        }

        private function createBuilder( mapper : CommandMapper ):PriorityEventCommandMappingBuilder
        {
            return new PriorityEventCommandMappingBuilder( mapper );
        }

		private function createMapper( trigger : ICommandTrigger ) : CommandMapper{
			return new CommandMapper( trigger, this );
		}

        private function getKey( type:String, eventClass:Class = null ) : String{
            return type + eventClass;
        }


    }
}