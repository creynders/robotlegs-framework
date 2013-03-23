package robotlegs.bender.extensions.commandCenter.impl
{
	/**
	 * @author creynder
	 */
	import flash.utils.Dictionary;

	import mockolate.decorations.Decorator;

	import robotlegs.bender.extensions.commandCenter.api.ICommandMapStrategy;
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;

	public class CommandTrigger implements ICommandTrigger{
		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		// TODO:change to const
		private var _mappingsList:Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

		// TODO:change to const
		private var _mappingsByCommandClass:Dictionary = new Dictionary();

		private var _strategy : ICommandMapStrategy;

		private var _decorated : ICommandTrigger;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/


		public function CommandTrigger(strategy : ICommandMapStrategy, decorated : ICommandTrigger = null)
		{
			_strategy = strategy;
			_decorated = decorated || this;
		}

		public function addMapping(mapping:ICommandMapping):void
		{
			_mappingsByCommandClass[mapping.commandClass] = mapping;
			_mappingsList.push( mapping );
			if( _mappingsList.length == 1 ){
				_strategy.registerTrigger( _decorated );
			}
		}

		public function removeMapping(mapping:ICommandMapping):void
		{
			delete _mappingsByCommandClass[mapping.commandClass];
			const index:int = _mappingsList.indexOf(mapping);
			if (index != -1)
			{
				_mappingsList.splice(index, 1);
			}
			if( _mappingsList.length <= 0 ){
				_strategy.unregisterTrigger( _decorated );
			}
		}

		public function getMappings():Vector.<ICommandMapping>
		{
			return _mappingsList;
		}

		public function getMappingFor(commandClass:Class):ICommandMapping
		{
			return _mappingsByCommandClass[commandClass];
		}
	}
}