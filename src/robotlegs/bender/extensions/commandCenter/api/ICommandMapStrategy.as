package robotlegs.bender.extensions.commandCenter.api
{
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;

	/**
	 * @author creynder
	 */
	public interface ICommandMapStrategy{
		function registerTrigger( trigger : * ):void;
		function unregisterTrigger( trigger : * ):void;
	}
}