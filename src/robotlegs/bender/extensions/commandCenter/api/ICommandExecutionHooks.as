package robotlegs.bender.extensions.commandCenter.api
{
	/**
	 * @author creynder
	 */
	public interface ICommandExecutionHooks{

		/**
		 * TODO: document
		 */
		function set mapPayload( value : Function ):void;
		function get mapPayload() : Function;

		/**
		 * TODO: document
		 */
		function set unmapPayload( value : Function ):void;
		function get unmapPayload() : Function;

		/**
		 * TODO: document
		 */
		function set whenExecuted( value : Function ):void;
		function get whenExecuted() : Function;
	}
}