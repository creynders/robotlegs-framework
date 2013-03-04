package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * @author creynder
     */
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    
    public class CommandMappingQueue implements ICommandMappingCollection, ICommandMappingIterator{
        public function CommandMappingQueue( queue : Vector.<ICommandMapping> = null )
        {
            _queue = queue || new Vector.<ICommandMapping>();
        }
        
        private var _queue : Vector.<ICommandMapping>;
        
        public function get isDone():Boolean
        {
            return _queue.length == 0;
        }
        
        private var _currentMapping : ICommandMapping;
        
        public function get currentMapping():ICommandMapping
        {
            return _currentMapping;
        }
        
        public function get length() : int{
            return _queue.length;
        }
        
        public function add(mapping:ICommandMapping):void
        {
            _queue.push( mapping );
        }
        
        public function remove(mapping:ICommandMapping):void
        {
            var index : int = _queue.indexOf( mapping );
            if( -1 >= index ){
                _queue.splice( index, 1 );
            }
        }
        
        public function first():ICommandMapping
        {
            _currentMapping = _queue.shift();
            return currentMapping;
        }
        
        public function next():ICommandMapping
        {
            return first();
        }
        
        public function clone() : CommandMappingQueue{
            return new CommandMappingQueue( _queue.concat() );
        }
    }
}