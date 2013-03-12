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
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
	import robotlegs.bender.extensions.commandCenter.impl.AbstractCommandExecutor;

	public class CallbackCommandExecutor extends AbstractCommandExecutor
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public var unmapPayloadCallback:Function;

		public var mapPayloadCallback:Function;

		public var whenCommandExecutedCallback:Function;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function CallbackCommandExecutor(trigger:ICommandTrigger, injector:Injector)
		{
			super(trigger, injector);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function execute():void
		{
			executeCommands(_trigger.getMappings());
		}

		/*============================================================================*/
		/* Protected Functions                                                        */
		/*============================================================================*/

		override protected function unmapPayload():void
		{
			unmapPayloadCallback && unmapPayloadCallback();
		}

		override protected function mapPayload():void
		{
			mapPayloadCallback && mapPayloadCallback();
		}

		override protected function whenCommandExecuted():void
		{
			whenCommandExecutedCallback && whenCommandExecutedCallback();
		}
	}
}