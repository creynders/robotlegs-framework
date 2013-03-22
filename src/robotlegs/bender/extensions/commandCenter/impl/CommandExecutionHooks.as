package robotlegs.bender.extensions.commandCenter.impl
{
	/**
	 * @author creynder
	 */
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutionHooks;

	public class CommandExecutionHooks implements ICommandExecutionHooks{

		private var _mapPayload : Function;

		public function get mapPayload():Function{
			return _mapPayload;
		}

		public function set mapPayload(value:Function):void
		{
			_mapPayload = value;
		}

		private var _unmapPayload : Function;

		public function get unmapPayload():Function{
			return _unmapPayload;
		}

		public function set unmapPayload(value:Function):void
		{
			_unmapPayload = value;
		}


		private var _whenExecuted : Function;

		public function get whenExecuted():Function{
			return _whenExecuted;
		}

		public function set whenExecuted(value:Function):void
		{
			_whenExecuted = value;
		}
	}
}