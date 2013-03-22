package robotlegs.bender.extensions.eventCommandMap.impl
{
	/**
	 * @author creynder
	 */
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutionHooks;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.impl.CommandExecutionHooks;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;

	public class EventCommandMapStrategy implements ICommandMapStrategy{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector : Injector;

		private var _dispatcher : IEventDispatcher;

		private var _commandMap : ICommandCenter;

		private var _triggers : Dictionary = new Dictionary( false );

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function EventCommandMapStrategy(injector : Injector, dispatcher : IEventDispatcher, commandMap : ICommandCenter)
		{
			_injector = injector;
			_dispatcher = dispatcher;
			_commandMap = commandMap;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		public function getTrigger( eventType : String, eventClass : Class = null ) : EventCommandTrigger{
			var trigger : EventCommandTrigger = _triggers[ eventType + eventClass ];
			if( !trigger ){
				trigger = _triggers[ eventType + eventClass ] = new EventCommandTrigger( eventType, eventClass );
			}
			return trigger;
		}

		/**
		 * @inheritDoc
		 */
		public function registerTrigger(trigger:*):void
		{
			var eventTrigger : EventCommandTrigger = trigger as EventCommandTrigger;
			_dispatcher.addEventListener( eventTrigger.type, handleEvent );
		}

		/**
		 * @inheritDoc
		 */
		public function unregisterTrigger(trigger:*):void
		{
			var eventTrigger : EventCommandTrigger = trigger as EventCommandTrigger;
			_dispatcher.removeEventListener( eventTrigger.type, handleEvent );
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		/**
		 * TODO: document
		 */
		protected function handleEvent( event : Event ) : void{

			var eventConstructor : Class = event["constructor"] as Class;
			var mappings : Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

			var strictMappings : Vector.<ICommandMapping> = _commandMap.getMappings( getTrigger( event.type, eventConstructor ) );
			strictMappings && ( mappings = mappings.concat( strictMappings ) );

			var looseMappings : Vector.<ICommandMapping> = _commandMap.getMappings( getTrigger( event.type ) );
			looseMappings && ( mappings = mappings.concat( looseMappings ) );

			if( mappings.length <= 0 ){
				return;
			}

			var hooks : ICommandExecutionHooks = new CommandExecutionHooks();

			hooks.mapPayload = function() : void{
				_injector.map(Event).toValue(event);
				if (eventConstructor != Event)
				{
					_injector.map( eventConstructor ).toValue(event);
				}
			}

			hooks.unmapPayload = function() : void{
				_injector.unmap(Event);
				if (eventConstructor != Event)
				{
					_injector.unmap( eventConstructor );
				}
			}
			_commandMap.executeCommands( mappings, hooks );
		}

	}
}