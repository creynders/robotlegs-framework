package robotlegs.bender.rewrite.signalCommandMap.impl
{
    /**
     * @author creynder
     */
    import flash.utils.Dictionary;
    
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandCenter;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;
    import robotlegs.bender.rewrite.commandcenter.impl.CommandMapper;
    import robotlegs.bender.rewrite.signalCommandMap.api.ISignalCommandMap;
    
    public class SignalCommandMap implements ISignalCommandMap{
        private var _injector:Injector;
        
        private var _commandMap:ICommandCenter;
        
        private const _signalTriggers:Dictionary = new Dictionary();
        
        public function SignalCommandMap(injector:Injector, commandMap:ICommandCenter)
        {
            _injector = injector;
            _commandMap = commandMap;
        }
        
        public function map(signalClass:Class, once:Boolean=false):ICommandMapper
        {
            const trigger:SignalCommandTrigger =
                _signalTriggers[signalClass] ||=
                createTrigger(signalClass);
            _commandMap.map( trigger );
            return createBuilder( trigger );
        }
        
        protected function createBuilder( trigger : ICommandTrigger ):ICommandMapper
        {
            return new CommandMapper( trigger );
        }
        
        protected function createTrigger(signalClass:Class):ICommandTrigger
        {
            var trigger : SignalCommandTrigger = new SignalCommandTrigger( signalClass );
            trigger.executor = createExecutor( trigger, signalClass );
            return trigger;
        }
        
        protected function createExecutor( trigger : ICommandTrigger, signalClass : Class ) : ICommandExecutor{
            return new SignalCommandExecutor( trigger, signalClass );
        }
    }
}