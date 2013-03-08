package robotlegs.bender.rewrite.priorityEventCommandMap.impl
{
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;
    import robotlegs.bender.rewrite.commandcenter.impl.CommandMapper;
    import robotlegs.bender.rewrite.eventCommandMap.impl.EventCommandTrigger;
    import robotlegs.bender.rewrite.priorityEventCommandMap.api.IPriorityEventCommandMapper;
    import robotlegs.bender.rewrite.priorityEventCommandMap.api.IPriorityEventCommandMappingConfig;

    /**
     * @author creynder
     */
    public class PriorityEventCommandMapper implements IPriorityEventCommandMapper, IPriorityEventCommandMappingConfig{
        private var _builder:CommandMapper
        private var _trigger : ICommandTrigger;
        private var _mapping : PriorityEventCommandMapping;
        
        public function PriorityEventCommandMapper( trigger : ICommandTrigger )
        {
            _trigger = trigger;
            _builder = new CommandMapper( trigger );
            _mapping = new PriorityEventCommandMapping();
            _trigger.addMapping( _mapping );
        }
        
        public function toCommand(commandClass:Class):IPriorityEventCommandMappingConfig{
            _builder.toCommand( commandClass );
            return this;
        }
        /**
         * Guards to check before allowing a command to execute
         * @param guards Guards
         * @return Self
         */
        public function withGuards(... guards):IPriorityEventCommandMappingConfig{
            _builder.withGuards( guards );
            return this;
        }
        
        /**
         * Hooks to run before command execution
         * @param hooks Hooks
         * @return Self
         */
        public function withHooks(... hooks):IPriorityEventCommandMappingConfig{
            _builder.withHooks( hooks );
            return this;
        }
        
        /**
         * Should this command only run once?
         * @param value Toggle
         * @return Self
         */
        public function once(value:Boolean = true):IPriorityEventCommandMappingConfig{
            _builder.once( value );
            return this;
        }
        
        public function withPriority( priority : int = 0 ) : IPriorityEventCommandMappingConfig{
            _mapping.priority = priority;
            return this;
        }
    }
}