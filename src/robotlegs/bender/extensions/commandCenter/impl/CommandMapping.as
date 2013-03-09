//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;

	/**
	 * @private
	 */
	public class CommandMapping implements ICommandMapping
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _commandClass:Class;


		/**
		 * @inheritDoc
		 */
		public function get commandClass():Class
		{
			return _commandClass;
		}
        
        
		private var _guards:Array = [];

		/**
		 * @inheritDoc
		 */
		public function get guards():Array
		{
			return _guards;
		}

		private var _hooks:Array = [];

		/**
		 * @inheritDoc
		 */
		public function get hooks():Array
		{
			return _hooks;
		}

		private var _fireOnce:Boolean;

		/**
		 * @inheritDoc
		 */
		public function get fireOnce():Boolean
		{
			return _fireOnce;
		}

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		/**
		 * Creates a Command Mapping
		 * @param commandClass The concrete Command class
		 */
		public function CommandMapping(commandClass:Class)
		{
			_commandClass = commandClass;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function addGuards(... guards):ICommandMapping
		{
			_guards = _guards.concat.apply(null, guards);
            return this;
		}

		/**
		 * @inheritDoc
		 */
		public function addHooks(... hooks):ICommandMapping
		{
			_hooks = _hooks.concat.apply(null, hooks);
            return this;
		}

		/**
		 * @inheritDoc
		 */
		public function setFireOnce( value : Boolean ) : ICommandMapping
		{
			_fireOnce = value;
            return this;
		}
        
        public function setCommandClass(value:Class):ICommandMapping{
            _commandClass = value;
            return this;
        }
        

		public function toString():String
		{
			return 'Command ' + _commandClass;
		}
	}
}
