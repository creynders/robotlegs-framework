//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter
{
	import robotlegs.bender.extensions.commandCenter.impl.AbstractCommandExecutorTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandCenterTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapperTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingListTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingTest;
	import robotlegs.bender.extensions.commandCenter.impl.ExecuteCommandTest;

	[RunWith("org.flexunit.runners.Suite")]
	[Suite]
	public class CommandCenterExtensionTestSuite
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public var commandCenter:CommandCenterTest;

		public var commandMappingTest:CommandMappingTest;

		public var commandMappingListTest:CommandMappingListTest;

		public var commandMapperTest:CommandMapperTest;

		public var commandCenterExtension:CommandCenterExtensionTest;

		public var commandExecutorTest:AbstractCommandExecutorTest;

		public var executeCommandtest : ExecuteCommandTest;
	}
}
