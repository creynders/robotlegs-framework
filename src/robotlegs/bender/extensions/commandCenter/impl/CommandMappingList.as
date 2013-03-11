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
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;

	/**
	 * @private
	 */
	public class CommandMappingList implements ICommandMappingCollection, ICommandMappingIterator
	{
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
        
        private var _nodesByMappings : Dictionary = new Dictionary( false );
        private var _currentNode : CommandMappingNode;

        private var _headNode:CommandMappingNode;
        private var _tailNode:CommandMappingNode;
        
		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

        /**
         * @private
         */
        public function get head() : ICommandMapping{
            var mapping : ICommandMapping;
            if( _headNode ){
                mapping = _headNode.mapping;
            }
            return mapping;
        }
        
        /**
         * @private
         */
        public function get tail() : ICommandMapping{
            var mapping : ICommandMapping;
            if( _tailNode ){
                mapping = _tailNode.mapping;
            }
            return mapping;
        }
        
		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
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
                var halo : CommandMappingNode = new CommandMappingNode();
                halo.nextNode = _headNode = _tailNode = node;
                _currentNode = halo;
			}
		}

		/**
		 * @inheritDoc
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
        
        /**
         * @inheritDoc
         */
        public function first():ICommandMapping
        {
            var mapping : ICommandMapping;
            if( _headNode ){
                mapping = _headNode.mapping;
                _currentNode = _headNode;
            }
            return mapping;
        }

        /**
         * @inheritDoc
         */
        public function next():ICommandMapping
        {
            var mapping : ICommandMapping;
            if( hasNext() ){
                _currentNode = _currentNode.nextNode;
                mapping = _currentNode.mapping;
            }
            return mapping;
        }
        
        /**
         * @inheritDoc
         */
        public function hasNext() : Boolean{
            return _currentNode && _currentNode.nextNode;
        }
        
        /**
         * TODO: only used in testing, drop?
         * @private
         */
        public function getNext( mapping : ICommandMapping ) : ICommandMapping{
            var next : ICommandMapping;
            var node : CommandMappingNode = _nodesByMappings[ mapping ]
            if( node && node.nextNode ){
                next = node.nextNode.mapping;
            }
            
            return next;
        }
        
        /**
         * TODO: only used in testing, drop?
         * @private
         */
        public function getPrevious( mapping : ICommandMapping ) : ICommandMapping{
            var previous : ICommandMapping;
            var node : CommandMappingNode = _nodesByMappings[ mapping ]
            if( node && node.previousNode ){
                previous = node.previousNode.mapping;
            }
            
            return previous;
        }
        
	}
}
