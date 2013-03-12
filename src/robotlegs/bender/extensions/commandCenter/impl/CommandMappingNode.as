//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;

	/**
	 * @author creynder
	 */
	public class CommandMappingNode
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _nextNode:CommandMappingNode;

		/**
		 * @private
		 */
		public function get nextNode():CommandMappingNode
		{
			return _nextNode;
		}

		/**
		 * @private
		 */
		public function set nextNode(value:CommandMappingNode):void
		{
			_nextNode = value;
		}

		private var _previousNode:CommandMappingNode;

		/**
		 * @private
		 */
		public function get previousNode():CommandMappingNode
		{
			return _previousNode;
		}

		/**
		 * @private
		 */
		public function set previousNode(value:CommandMappingNode):void
		{
			_previousNode = value;
		}

		private var _mapping:ICommandMapping;

		/**
		 * @private
		 */
		public function get mapping():ICommandMapping
		{
			return _mapping;
		}

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function CommandMappingNode(mapping:ICommandMapping = null)
		{
			_mapping = mapping;
		}
	}
}
