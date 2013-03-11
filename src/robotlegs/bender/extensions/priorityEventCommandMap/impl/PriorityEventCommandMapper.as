package robotlegs.bender.extensions.priorityEventCommandMap.impl
{
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMapper;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMapping;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMappingConfig;

    /**
     * @author creynder
     */
    public class PriorityEventCommandMapper implements IPriorityEventCommandMapper, IPriorityEventCommandMappingConfig{
        
        /*============================================================================*/
        /* Private Functions                                                          */
        /*============================================================================*/
        
        private var _baseMapper:CommandMapper;
        
        private function get mapping():IPriorityEventCommandMapping{
            return _baseMapper.mapping as IPriorityEventCommandMapping;
        }
        
        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/
        
        public function PriorityEventCommandMapper( trigger : ICommandTrigger, mappingFactory : ICommandMappingFactory )
        {
            _baseMapper = new CommandMapper( trigger, mappingFactory );
        }
        
        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/
        
        
        public function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig{
            _baseMapper.toCommand( commandClass );
            return this;
        }
        
        public function once(value:Boolean=true):IPriorityEventCommandMappingConfig
        {
            _baseMapper.once( value );
            return this;
        }
        
        public function withGuards(...guards):IPriorityEventCommandMappingConfig
        {
            _baseMapper.withGuards( guards );
            return this;
        }
        
        public function withHooks(...hooks):IPriorityEventCommandMappingConfig
        {
            _baseMapper.withHooks( hooks );
            return this;
        }
        
        public function withPriority(priority:int=0):IPriorityEventCommandMappingConfig
        {
            mapping.setPriority( priority );
            return this;
        }
        
    }
}