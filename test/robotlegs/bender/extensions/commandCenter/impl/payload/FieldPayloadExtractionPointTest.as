//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl.payload
{
	import flash.text.StaticText;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import robotlegs.bender.extensions.commandCenter.impl.payload.IPayloadExtractionPoint;

	public class FieldPayloadExtractionPointTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:IPayloadExtractionPoint;

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function extracts_value_from_property():void
		{
			var instance:ExtractableObject = new ExtractableObject();
			subject = new FieldPayloadExtractionPoint('extractableProperty', String);
			assertThat(subject.extractFrom(instance), equalTo(instance.extractableProperty));
		}

		[Test]
		public function extracts_value_from_getter():void
		{
			var instance:ExtractableObject = new ExtractableObject();
			subject = new FieldPayloadExtractionPoint('extractableGetter', String);
			assertThat(subject.extractFrom(instance), equalTo(instance.extractableGetter));
		}
	}
}

class ExtractableObject
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	public var extractableProperty:String = 'extractableProperty';

	public function get extractableGetter():String
	{
		return 'extractableGetter';
	}
}
