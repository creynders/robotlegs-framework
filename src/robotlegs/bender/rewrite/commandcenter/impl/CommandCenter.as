package robotlegs.bender.rewrite.commandcenter.impl
{
    import robotlegs.bender.rewrite.commandcenter.api.ICommandCenter;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapper;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandTrigger;

    /**
     * @author creynder
     */
    public class CommandCenter implements ICommandCenter{
        public function CommandCenter()
        {
        }
        
        public function map(trigger:ICommandTrigger):void
        {
            //store trigger
        }
        
        public function unmap(trigger:ICommandTrigger):void
        {
            //remove trigger
        }
        
    }
}