package robotlegs.bender.extensions.eventCommandMap.impl
{
	import flash.events.Event;

	/**
	 * @author creynder
	 */
	public class EventCommandTrigger{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _type : String;

		/**
		 * TODO: document
		 */
		public function get type():String{
			return _type;
		}

		/**
		 * TODO: document
		 */
		public function set type(value:String):void{
			_type = value;
		}


		private var _eventClass : Class;
		/**
		 * TODO: document
		 */
		public function get eventClass():Class{
			return _eventClass;
		}

		/**
		 * TODO: document
		 */
		public function set eventClass(value:Class):void{
			_eventClass = value;
		}

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function EventCommandTrigger( type : String, eventClass : Class = null)
		{
			_type = type;
			_eventClass = eventClass || Event;
		}
	}
}