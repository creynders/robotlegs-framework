//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter
{
	import robotlegs.bender.extensions.commandCenter.impl.CommandCenterTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandExecutorTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapperTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandTriggerTest;

	[RunWith("org.flexunit.runners.Suite")]
	[Suite]
	public class CommandCenterExtensionTestSuite
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public var commandCenterExtension:CommandCenterExtensionTest;

		public var commandCenter:CommandCenterTest;

		public var commandMapping:CommandMappingTest;

		public var commandMapper:CommandMapperTest;

		public var commandExecutor:CommandExecutorTest;

		public var commandTrigger:CommandTriggerTest;

	}
}
