package robotlegs.bender.rewrite.eventCommandMap.impl
{
    /**
     * @author creynder
     */
    import robotlegs.bender.rewrite.commandcenter.api.ICommandExecutor;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapping;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;
    
    public class EventCommandTrigger implements ICommandTrigger{
        public function EventCommandTrigger(type:String, eventClass:Class)
        {
            _type = type;
            _eventClass = eventClass;
        }
        
        private var _type : String;
        private var _eventClass : Class;
        
        private var _executor : ICommandExecutor;
        public function set executor( value : ICommandExecutor ) : void{
            _executor = value;
        }
        

        public function addMapping(mapping:ICommandMapping):void
        {
            //store mapping
        }
        
        public function removeMapping(mapping:ICommandMapping):void
        {
            //remove mapping
        }
        
    }
}