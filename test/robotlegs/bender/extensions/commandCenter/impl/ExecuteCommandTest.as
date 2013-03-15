//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl
{
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.swiftsuspenders.Injector;

	public class ExecuteCommandTest{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector : Injector;

		private var _reportedExecutions : Array;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function setup():void{
			_reportedExecutions = [];
			_injector = new Injector();
			_injector.map( Function, 'reportingFunction' ).toValue( reportingFunc );
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function test_self():void{
			assertThat( true, equalTo( true ) );
		}

		[Test]
		public function test_executes_command_when_execute_method_found():void
		{
			var command : Object = _injector.instantiateUnmapped( CommandWithExecute );
			executeCommand( command );
			assertThat( _reportedExecutions, array( [ CommandWithExecute ] ) );
		}

		[Test]
		public function test_doesnt_throw_error_when_execute_method_not_found() : void{
			var passedError : Error;
			try{
				var command : Object = _injector.instantiateUnmapped( CommandWithoutExecute );
				executeCommand( command );
			}catch( error : Error ) {
				passedError = error;
			}

			assertThat( passedError, nullValue() );

		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function reportingFunc( commandClass : Class ) : void{
			_reportedExecutions.push( commandClass );
		}

	}
}

class CommandWithExecute{
	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function execute():void
	{
		reportingFunc(CommandWithExecute);
	}
}

class CommandWithoutExecute
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Inject(name="reportingFunction")]
	public var reportingFunc:Function;

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	[PostConstruct]
	public function init():void
	{
		reportingFunc(CommandWithoutExecute);
	}
}
