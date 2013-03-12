package robotlegs.bender.extensions.commandCenter.impl
{
    /**
     * Adapter to BaseCommandMapper
     * @author creynder
     */
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingFactory;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingBuilder;
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;
    import robotlegs.bender.framework.api.ILogger;
    
    public class CommandMappingBuilder implements ICommandMappingBuilder, ICommandMappingConfig, ICommandUnmapper{
        
        private var _mapper : CommandMapper;
        
        public function CommandMappingBuilder(trigger:ICommandTrigger, factory : ICommandMappingFactory, logger:ILogger = null)
        {
            _mapper = new CommandMapper( trigger, factory, logger );
        }
        
        public function toCommand(commandClass:Class):ICommandMappingConfig
        {
            _mapper.mapCommand( commandClass );
            return this;
        }
        
        public function once(value:Boolean=true):ICommandMappingConfig
        {
            _mapper.mapping.setFireOnce( value );
            return this;
        }
        
        public function withGuards(...guards):ICommandMappingConfig
        {
            _mapper.mapping.addGuards.apply( null, guards );
            return this;
        }
        
        public function withHooks(...hooks):ICommandMappingConfig
        {
            _mapper.mapping.addHooks.apply( null, hooks );
            return this;
        }
        
        public function fromAll():void
        {
            _mapper.unmapAll();
        }
        
        public function fromCommand(commandClass:Class):void
        {
            _mapper.unmapCommand( commandClass );
        }
        
        
    }
}