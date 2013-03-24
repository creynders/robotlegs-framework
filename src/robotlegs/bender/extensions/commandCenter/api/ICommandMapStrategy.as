package robotlegs.bender.extensions.commandCenter.api
{
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;

	/**
	 * @author creynder
	 */
	public interface ICommandMapStrategy{

		/**
		 * TODO: document and rename [!]
		 */
		function registerTrigger( trigger : ICommandTrigger ):void;

		/**
		 * TODO: document and rename [!]
		 */
		function unregisterTrigger( trigger : ICommandTrigger ):void;

	}
}