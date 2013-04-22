package robotlegs.bender.extensions.commandCenter
{
	import robotlegs.bender.extensions.commandCenter.api.IExecuteMethodMap;
	import robotlegs.bender.extensions.commandCenter.impl.execution.ExecuteMethodMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class CommandCenterExtension implements IExtension{

		public function extend(context:IContext):void
		{
			context.injector.map(IExecuteMethodMap).toSingleton(ExecuteMethodMap);
		}

	}
}