//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import flash.utils.Dictionary;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingList;

	/**
	 * @private
	 */
	public class CommandMappingList implements ICommandMappingList
	{
        
        private var _nodesByMappings : Dictionary = new Dictionary( false );

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _headNode:CommandMappingNode;

		/**
		 * @private
		 */
		public function get headNode():CommandMappingNode
		{
			return _headNode;
		}

		private var _tailNode:CommandMappingNode;

		/**
		 * @private
		 */
		public function get tailNode():CommandMappingNode
		{
			return _tailNode;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @private
		 */
		public function add(mapping:ICommandMapping):void
		{
            var node : CommandMappingNode = new CommandMappingNode( mapping );
            _nodesByMappings[ mapping ] = node;
			if (_tailNode)
			{
				_tailNode.nextNode = node;
				node.previousNode = _tailNode;
				_tailNode = node;
			}
			else
			{
				_headNode = _tailNode = node;
			}
		}

		/**
		 * @private
		 */
		public function remove(mapping:ICommandMapping):void
		{
            var node : CommandMappingNode = _nodesByMappings[ mapping ];
			if (node == _headNode)
			{
				_headNode = _headNode.nextNode;
			}
			if (node == _tailNode)
			{
				_tailNode = _tailNode.previousNode;
			}
			if (node.previousNode)
			{
				node.previousNode.nextNode = node.nextNode;
			}
			if (node.nextNode)
			{
				node.nextNode.previousNode = node.previousNode;
			}
            delete _nodesByMappings[ mapping ];
		}
        
        public function getNext( mapping : ICommandMapping ) : ICommandMapping{
            var next : ICommandMapping;
            var node : CommandMappingNode = _nodesByMappings[ mapping ]
            if( node && node.nextNode ){
                next = node.nextNode.mapping;
            }
            
            return next;
        }
        
        public function getPrevious( mapping : ICommandMapping ) : ICommandMapping{
            var previous : ICommandMapping;
            var node : CommandMappingNode = _nodesByMappings[ mapping ]
            if( node && node.previousNode ){
                previous = node.previousNode.mapping;
            }
            
            return previous;
        }
        
        public function getHead() : ICommandMapping{
            var mapping : ICommandMapping;
            if( _headNode ){
                mapping = _headNode.mapping;
            }
            return mapping;
        }
        
        public function getTail() : ICommandMapping{
            var mapping : ICommandMapping;
            if( _tailNode ){
                mapping = _tailNode.mapping;
            }
            return mapping;
        }
	}
}
