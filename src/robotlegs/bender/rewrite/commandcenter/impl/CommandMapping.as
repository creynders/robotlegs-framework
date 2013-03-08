package robotlegs.bender.rewrite.commandcenter.impl
{
    /**
     * @author creynder
     */
    import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;
    import robotlegs.bender.rewrite.commandcenter.api.ICommandMapping;
    
    public class CommandMapping implements ICommandMapping{
        public function CommandMapping()
        {
        }
        
        public function get commandClass():Class
        {
            return null;
        }
        
        public function get guards():Array
        {
            return null;
        }
        
        public function get hooks():Array
        {
            return null;
        }
        
        public function get fireOnce():Boolean
        {
            return false;
        }
    }
}