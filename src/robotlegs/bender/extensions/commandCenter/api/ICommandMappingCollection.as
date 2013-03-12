//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.api
{

	/**
	 * TODO: document
	 */
	public interface ICommandMappingCollection
	{

		/**
		 * TODO: document
		 */
		function add(mapping:ICommandMapping):void;

		/**
		 * TODO: document
		 */
		function remove(mapping:ICommandMapping):void;

		/**
		 * TODO: document
		 */
		function first():ICommandMapping;

		/**
		 * TODO: document
		 */
		function next():ICommandMapping;

		/**
		 * TODO: document
		 */
		function hasNext():Boolean;
	}
}
