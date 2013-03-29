package robotlegs.bender.extensions.commandCenter.api
{
	/**
	 * @author creynder
	 */
	public interface ICommandCenter{
		function execute( commandClass : Class ) : void;
		function detain( command : Object ) : void;
		function release( command : Object ) : void;
	}
}