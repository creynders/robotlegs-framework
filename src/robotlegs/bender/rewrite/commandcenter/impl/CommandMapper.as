package robotlegs.bender.rewrite.commandcenter.impl
{
    /**
     * @author creynder
     */
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapping;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMappingConfig;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;
    
    public class CommandMapper implements ICommandMapper, ICommandMappingConfig{
        public function CommandMapper( trigger : ICommandTrigger )
        {
            _trigger = trigger;
            _mapping = new CommandMapping();
            _trigger.addMapping( _mapping );
        }
        
        private var _trigger : ICommandTrigger;
        private var _mapping : CommandMapping;
        
        public function toCommand(commandClass:Class):ICommandMappingConfig
        {
            //store in mapping
            return this;
        }
        
        public function withGuards(...guards):ICommandMappingConfig
        {
            //store in mapping
            return this;
        }
        
        public function withHooks(...hooks):ICommandMappingConfig
        {
            //store in mapping
            return this;
        }
        
        public function once(value:Boolean=true):ICommandMappingConfig
        {
            //store in mapping
            return this;
        }
        
    }
}