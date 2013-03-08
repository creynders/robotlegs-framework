package robotlegs.bender.rewrite.commandcenter.api
{
    /**
     * @author creynder
     */
    public interface ICommandMappingConfig{
        /**
         * Guards to check before allowing a command to execute
         * @param guards Guards
         * @return Self
         */
        function withGuards(... guards):ICommandMappingConfig;
        
        /**
         * Hooks to run before command execution
         * @param hooks Hooks
         * @return Self
         */
        function withHooks(... hooks):ICommandMappingConfig;
        
        /**
         * Should this command only run once?
         * @param value Toggle
         * @return Self
         */
        function once(value:Boolean = true):ICommandMappingConfig;
       
    }
}