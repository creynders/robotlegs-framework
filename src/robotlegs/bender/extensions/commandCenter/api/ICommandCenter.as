//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * Creates command mappings for triggers
	 */
	public interface ICommandCenter
	{

		/**
		 * TODO: document
		 */
		function withTriggerFactory(triggerFactory:Function):ICommandCenter;

		/**
		 * TODO: document
		 */
		function withKeyFactory(keyFactory:Function):ICommandCenter;

		/**
		 * TODO: document
		 */
		function withLogger(logger:ILogger):ICommandCenter

		/**
		 * TODO: document
		 */
		function removeTrigger(... key):void;

		/**
		 * TODO: document
		 */
		function getOrCreateNewTrigger(... key):ICommandTrigger;
	}
}
