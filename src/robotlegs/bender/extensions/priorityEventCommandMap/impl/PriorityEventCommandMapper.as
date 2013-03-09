package robotlegs.bender.extensions.priorityEventCommandMap.impl
{
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMapper;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMappingConfig;

    /**
     * @author creynder
     */
    public class PriorityEventCommandMapper implements IPriorityEventCommandMapper, IPriorityEventCommandMappingConfig{
        private var _baseMapper:CommandMapper;
        public function PriorityEventCommandMapper( trigger : ICommandTrigger, mappingFactory : ICommandMappingFactory )
        {
            _baseMapper = new CommandMapper( trigger, mappingFactory );
        }
        
        public function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig{
            _baseMapper.toCommand( commandClass );
            return this;
        }
    }
}