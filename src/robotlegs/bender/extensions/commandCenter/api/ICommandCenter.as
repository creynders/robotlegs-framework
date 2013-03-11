//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;

	/**
	 * Creates command mappings for triggers
	 */
	public interface ICommandCenter
	{
		/**
		 * Maps a trigger to a key
		 * @param trigger The trigger to map
         * @param key The key to map the trigger to
		 */
		function map(trigger:ICommandTrigger, key : *):void;

		/**
		 * Unmaps a trigger mapped to the key
		 * @param key The key to the trigger to unmap
		 */
		function unmap( key : * ):void;
        
        /**
         * TODO: document
         */
        function getTrigger( key : * ) : ICommandTrigger;
	}
}
