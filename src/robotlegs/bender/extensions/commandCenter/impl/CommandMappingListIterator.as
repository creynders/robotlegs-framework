package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * @author creynder
     */
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingList;
    
    public class CommandMappingListIterator implements ICommandMappingIterator{
        public function CommandMappingListIterator( mappings : CommandMappingList )
        {
            _mappings = mappings;
        }
        
        private var _currentNode : CommandMappingNode;
        
        private var _mappings : CommandMappingList;
        
        public function first():ICommandMapping
        {
            var mapping : ICommandMapping;
            if( _mappings.headNode ){
                mapping = _mappings.headNode.mapping;
                _currentNode = _mappings.headNode;
            }
            return mapping;
        }
        
        public function next():ICommandMapping
        {
            if( _currentNode ){
                _currentNode = _currentNode.nextNode;
            }
            return currentMapping;
        }
        
        public function get isDone():Boolean
        {
            return _currentNode == _mappings.tailNode;
        }
        
        public function get currentMapping():ICommandMapping
        {
            var mapping : ICommandMapping;
            if( _currentNode ){
                mapping = _currentNode.mapping;
            }
            return mapping;
        }
    }
}