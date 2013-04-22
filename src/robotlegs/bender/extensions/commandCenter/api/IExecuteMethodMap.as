package robotlegs.bender.extensions.commandCenter.api
{
	public interface IExecuteMethodMap{
		function getExecuteMethodForCommandClass(commandClass:Class):String;
	}
}