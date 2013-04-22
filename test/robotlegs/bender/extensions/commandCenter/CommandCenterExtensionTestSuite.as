//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter
{
	import robotlegs.bender.extensions.commandCenter.impl.CommandExecutorTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMapperTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingListTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandMappingTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandPayloadTest;
	import robotlegs.bender.extensions.commandCenter.impl.CommandTriggerMapTest;
	import robotlegs.bender.extensions.commandCenter.impl.execution.ExecutionReflectorTest;
	import robotlegs.bender.extensions.commandCenter.impl.payload.FieldPayloadExtractionPointTest;
	import robotlegs.bender.extensions.commandCenter.impl.payload.MethodPayloadExtractionPointTest;
	import robotlegs.bender.extensions.commandCenter.impl.payload.PayloadReflectorTest;

	[RunWith("org.flexunit.runners.Suite")]
	[Suite]
	public class CommandCenterExtensionTestSuite
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public var commandCenterExtension : CommandCenterExtensionTest;

		public var commandTriggerMap:CommandTriggerMapTest;

		public var commandMapper:CommandMapperTest;

		public var commandMapping:CommandMappingTest;

		public var commandExecutor:CommandExecutorTest;

		public var commandMappingList:CommandMappingListTest;

		public var commandPayload:CommandPayloadTest;

		public var executionReflector:ExecutionReflectorTest;

		public var fieldPayloadExtractionPoint:FieldPayloadExtractionPointTest;

		public var methodPayloadExtractionPoint:MethodPayloadExtractionPointTest;

		public var payloadReflector : PayloadReflectorTest;
	}
}
