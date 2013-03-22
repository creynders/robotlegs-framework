package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.Event;

	/**
	 * @author creynder
	 */
	public class EventCommandTrigger{

		private var _type : String;

		public function get type():String{
			return _type;
		}

		public function set type(value:String):void{
			_type = value;
		}


		private var _eventClass : Class;

		public function get eventClass():Class{
			return _eventClass;
		}

		public function set eventClass(value:Class):void{
			_eventClass = value;
		}


		public function EventCommandTrigger( type : String, eventClass : Class = null)
		{
			_type = type;
			_eventClass = eventClass || Event;
		}
	}
}