package robotlegs.bender.extensions.commandCenter.support
{
	/**
	 * @author creynder
	 */
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutionHooks;
	
	public class NullCommandExecutionHooks implements ICommandExecutionHooks{
		public function NullCommandExecutionHooks()
		{
		}
		
		public function set mapPayload(value:Function):void
		{
		}
		
		public function get mapPayload():Function
		{
			return null;
		}
		
		public function set unmapPayload(value:Function):void
		{
		}
		
		public function get unmapPayload():Function
		{
			return null;
		}
		
		public function set whenCommandExecuted(value:Function):void
		{
		}
		
		public function get whenCommandExecuted():Function
		{
			return null;
		}
	}
}