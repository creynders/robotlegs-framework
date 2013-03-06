package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * @author creynder
     */
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
    
    public class CommandMappingQueue implements ICommandMappingCollection, ICommandMappingIterator{
        
        /*============================================================================*/
        /* Public Properties                                                          */
        /*============================================================================*/
        
        /**
         * TODO: document
         */
        public function get length() : int{
            return _queue.length;
        }
        
        /*============================================================================*/
        /* Private Properties                                                         */
        /*============================================================================*/
        
        private var _queue : Vector.<ICommandMapping>;
        
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/
        
        public function CommandMappingQueue( queue : Vector.<ICommandMapping> = null )
        {
            _queue = queue || new Vector.<ICommandMapping>();
        }
        
        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/
        
        /**
         * @inheritDoc
         */ 
        public function add(mapping:ICommandMapping):void
        {
            _queue.push( mapping );
        }
        
        /**
         * @inheritDoc
         */ 
        public function remove(mapping:ICommandMapping):void
        {
            var index : int = _queue.indexOf( mapping );
            if( index > -1 ){
                _queue.splice( index, 1 );
            }
        }
        
        /**
         * @inheritDoc
         */ 
        public function first():ICommandMapping
        {
            return _queue.shift();
        }
        
        /**
         * @inheritDoc
         */ 
        public function next():ICommandMapping
        {
            return first();
        }
        
        public function hasNext():Boolean
        {
            return length>0;
        }
        
        /**
         * TODO: document
         */
        public function clone() : CommandMappingQueue{
            return new CommandMappingQueue( _queue.concat() );
        }
        
        public function hasMapping( mapping : ICommandMapping ) : Boolean{
            var index : int = _queue.indexOf( mapping ) 
            return index > -1;
        }
        
    }
}