package robotlegs.bender.extensions.priorityEventCommandMap.impl
{
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMapper;
    import robotlegs.bender.extensions.commandCenter.impl.CommandMappingBuilder;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMapping;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMappingBuilder;
    import robotlegs.bender.extensions.priorityEventCommandMap.api.IPriorityEventCommandMappingConfig;
    import robotlegs.bender.framework.api.ILogger;

    /**
     * @author creynder
     */
    public class PriorityEventCommandMappingBuilder implements IPriorityEventCommandMappingBuilder, IPriorityEventCommandMappingConfig{

        /*============================================================================*/
        /* Private Functions                                                          */
        /*============================================================================*/

        private var _baseMapper:CommandMapper;
		private var _mapping : IPriorityEventCommandMapping;

        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/

        public function PriorityEventCommandMappingBuilder( mapper : CommandMapper, logger : ILogger = null )
        {
			_baseMapper = mapper;
        }

        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/


        public function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig{
            _mapping = ( _baseMapper.mapCommand( commandClass ) as IPriorityEventCommandMapping);
            return this;
        }

        public function withGuards(...guards):IPriorityEventCommandMappingConfig
        {
            _mapping.addGuards.apply( null, guards );
            return this;
        }

        public function withHooks(...hooks):IPriorityEventCommandMappingConfig
        {
            _mapping.addHooks.apply( null, hooks );
            return this;
        }

        public function withPriority(priority:int=0):IPriorityEventCommandMappingConfig
        {
            _mapping.setPriority( priority );
            return this;
        }

    }
}