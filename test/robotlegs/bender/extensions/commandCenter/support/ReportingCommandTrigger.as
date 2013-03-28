//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.support
{
	/**
	 * @author creynder
	 */
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.impl.CommandTrigger;
	import robotlegs.bender.framework.api.ILogger;

	public class ReportingCommandTrigger extends CommandTrigger
	{

		/*============================================================================*/
		/* Public Static Properties                                                   */
		/*============================================================================*/

		public static const ACTIVATE:String = 'activate';

		public static const DEACTIVATE:String = 'deactivate';

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Inject(name="reportingFunction")]
		public var reportingFunction:Function;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function ReportingCommandTrigger()
		{
			super();
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		override public function activate():void
		{
			reportingFunction(ACTIVATE);
			super.activate();
		}

		override public function deactivate():void
		{
			reportingFunction(DEACTIVATE);
			super.deactivate();
		}
	}
}