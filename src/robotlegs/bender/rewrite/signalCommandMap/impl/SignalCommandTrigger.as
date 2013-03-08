package robotlegs.bender.rewrite.signalCommandMap.impl
{
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapping;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;

    /**
     * @author creynder
     */
    public class SignalCommandTrigger implements ICommandTrigger{
        public function SignalCommandTrigger(signalClass:Class)
        {
        }
        
        private var _executor : SignalCommandExecutor
        public function set executor( value : SignalCommandExecutor ) : void{
            _executor = value;
        }
        
        public function addMapping(mapping:ICommandMapping):void
        {
            
        }
        
        public function removeMapping(mapping:ICommandMapping):void
        {
            
        }
        
    }
}