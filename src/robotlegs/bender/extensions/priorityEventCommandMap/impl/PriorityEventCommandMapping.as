package robotlegs.bender.extensions.priorityEventCommandMap.impl
{
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMapping;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMapping;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMappingConfig;
    

    /**
     * @author creynder
     */
    public class PriorityEventCommandMapping implements IPriorityEventCommandMapping{
        
        private var _baseMapping : CommandMapping;
        private var _priority : int = 0;
        
        public function PriorityEventCommandMapping( commandClass : Class )
        {
            _baseMapping = new CommandMapping( commandClass );
        }
        
        public function addGuards(...guards):ICommandMapping
        {
            _baseMapping.addGuards( guards );
            return this;
        }
        
        public function addHooks(...hooks):ICommandMapping
        {
            _baseMapping.addHooks( hooks );
            return this;
        }
        
        public function setCommandClass(commandClass:Class):ICommandMapping
        {
            _baseMapping.setCommandClass( commandClass );
            return this;
        }
        
        public function setFireOnce(value:Boolean):ICommandMapping
        {
            _baseMapping.setFireOnce( value );
            return this;
        }
        
        
        public function get commandClass():Class
        {
            return _baseMapping.commandClass;
        }
        
        public function get fireOnce():Boolean
        {
            return _baseMapping.fireOnce;
        }
        
        public function get guards():Array
        {
            return _baseMapping.guards;
        }
        
        public function get hooks():Array
        {
            return _baseMapping.hooks;
        }
        
        public function get priority():int
        {
            return _priority;
        }
        
        public function setPriority(value:int=0):IPriorityEventCommandMapping
        {
            _priority = value;
            return this;
        }
        
    }
}