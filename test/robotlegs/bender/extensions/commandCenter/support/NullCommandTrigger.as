//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.support
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandExecutor;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingCollection;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMappingIterator;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;

	public class NullCommandTrigger implements ICommandTrigger
	{

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function NullCommandTrigger()
		{
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function addMapping(mapping:ICommandMapping):void
		{
		}

		public function removeMapping(mapping:ICommandMapping):void
		{
		}
        
        public function getMappings() : ICommandMappingIterator{
            return null;
        }
        
        public function getMappingFor(commandClass:Class):ICommandMapping
        {
            return null;
        }
        
        public function setExecutor(executor:ICommandExecutor):void
        {
            
        }
        
    }
}
