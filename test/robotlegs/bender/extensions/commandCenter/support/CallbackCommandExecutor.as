package robotlegs.bender.extensions.commandCenter.support
{
    /**
     * @author creynder
     */
    import org.swiftsuspenders.Injector;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
    import robotlegs.bender.extensions.commandCenter.impl.AbstractCommandExecutor;
    
    public class CallbackCommandExecutor extends AbstractCommandExecutor{
        public function CallbackCommandExecutor(trigger:ICommandTrigger, injector:Injector)
        {
            super(trigger, injector);
        }
        
        public var unmapPayloadCallback : Function;
        public var mapPayloadCallback : Function;
        public var whenCommandExecutedCallback : Function;
        
        public function execute() : void{
            executeCommands( _trigger.getMappings() );
        }
        
        override protected function unmapPayload():void
        {
            unmapPayloadCallback && unmapPayloadCallback();
        }
        
        override protected function mapPayload():void
        {
            mapPayloadCallback && mapPayloadCallback();
        }
        
        override protected function whenCommandExecuted():void
        {
            whenCommandExecutedCallback && whenCommandExecutedCallback();
        }
        
        
    }
}