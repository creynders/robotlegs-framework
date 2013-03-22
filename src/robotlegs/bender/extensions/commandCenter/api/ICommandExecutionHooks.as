package robotlegs.bender.extensions.commandCenter.api
{
	/**
	 * @author creynder
	 */
	public interface ICommandExecutionHooks{
		function set mapPayload( value : Function ):void;
		function get mapPayload() : Function;

		function set unmapPayload( value : Function ):void;
		function get unmapPayload() : Function;

		function set whenExecuted( value : Function ):void;
		function get whenExecuted() : Function;
	}
}