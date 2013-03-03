package robotlegs.bender.extensions.commandCenter.impl
{
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;

    /**
     * @author creynder
     */
    public class CommandMappingNode{
        public function CommandMappingNode( mapping : ICommandMapping )
        {
            _mapping = mapping;
        }
        
        private var _nextNode : CommandMappingNode;

        public function get nextNode():CommandMappingNode{
            return _nextNode;
        }

        public function set nextNode(value:CommandMappingNode):void{
            _nextNode = value;
        }
        
        private var _previousNode : CommandMappingNode;

        public function get previousNode():CommandMappingNode{
            return _previousNode;
        }

        public function set previousNode(value:CommandMappingNode):void{
            _previousNode = value;
        }
        
        private var _mapping:ICommandMapping;
        
        public function get mapping() : ICommandMapping{
            return _mapping;
        }


    }
}