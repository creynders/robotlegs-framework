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

	/**
	 * @private
	 */
	public class CommandMappingList implements ICommandMappingCollection
	{
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
        
        private var _currentNode : CommandMapping;

        private var _headNode:CommandMapping;
        private var _tailNode:CommandMapping;
        
		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

        /**
         * @private
         */
        public function get head() : ICommandMapping{
            return _headNode;
        }
        
        /**
         * @private
         */
        public function get tail() : ICommandMapping{
            return _tailNode;
        }
        
		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function add(mapping:ICommandMapping):void
		{
            var node : CommandMapping = mapping as CommandMapping;
			if (_tailNode)
			{
				_tailNode.nextNode = node;
				node.previousNode = _tailNode;
				_tailNode = node;
			}
			else
			{
                var halo : CommandMapping = new CommandMapping( null );
                halo.nextNode = _headNode = _tailNode = node;
                _currentNode = halo;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function remove(mapping:ICommandMapping):void
		{
            var node : CommandMapping = mapping as CommandMapping;
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
		}
        
        /**
         * @inheritDoc
         */
        public function first():ICommandMapping
        {
            return _currentNode = _headNode;
        }

        /**
         * @inheritDoc
         */
        public function next():ICommandMapping
        {
            return _currentNode &&= _currentNode.nextNode;
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
            return ( mapping as CommandMapping ).nextNode;
        }
        
        /**
         * TODO: only used in testing, drop?
         * @private
         */
        public function getPrevious( mapping : ICommandMapping ) : ICommandMapping{
            return ( mapping as CommandMapping ).previousNode;
        }
        
	}
}
