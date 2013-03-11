package robotlegs.bender.extensions.commandCenter.impl
{
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;

    /**
     * @author creynder
     */
    public class CommandMappingNode{

        /*============================================================================*/
        /* Public Properties                                                          */
        /*============================================================================*/
        
        private var _nextNode : CommandMappingNode;
        
        /**
         * @private
         */
        public function get nextNode():CommandMappingNode{
            return _nextNode;
        }
        
        public function set nextNode(value:CommandMappingNode):void{
            _nextNode = value;
        }
        
        private var _previousNode : CommandMappingNode;
        
        /**
         * @private
         */
        public function get previousNode():CommandMappingNode{
            return _previousNode;
        }
        
        public function set previousNode(value:CommandMappingNode):void{
            _previousNode = value;
        }
        
        private var _mapping:ICommandMapping;
        
        /**
         * @private
         */
        public function get mapping() : ICommandMapping{
            return _mapping;
        }
        
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/
        
        /**
         * TODO: document
         */
        public function CommandMappingNode( mapping : ICommandMapping = null )
        {
            _mapping = mapping;
        }
        

    }
}