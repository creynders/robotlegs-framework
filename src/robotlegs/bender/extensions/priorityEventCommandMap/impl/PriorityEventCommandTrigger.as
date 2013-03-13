package robotlegs.bender.extensions.priorityEventCommandMap.impl
{
    import flash.events.IEventDispatcher;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
    import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
    import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;

    /**
     * @author creynder
     */
    public class PriorityEventCommandTrigger implements ICommandTrigger{

        /*============================================================================*/
        /* Constructor                                                                */
        /*============================================================================*/

        public function PriorityEventCommandTrigger(			injector:Injector,
                                                                dispatcher:IEventDispatcher,
                                                                type:String,
                                                                eventClass:Class = null)

        {
        }

        /*============================================================================*/
        /* Public Functions                                                           */
        /*============================================================================*/


        public function addMapping(mapping:ICommandMapping):void
        {

        }

        public function getMappingFor(commandClass:Class):ICommandMapping
        {
            return null;
        }

        public function getMappings():ICommandMappingCollection
        {
            //sort by priority and then return [!]
            return null;
        }

        public function removeMapping(mapping:ICommandMapping):void
        {

        }

    }
}