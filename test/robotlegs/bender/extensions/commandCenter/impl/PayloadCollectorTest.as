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
	import org.hamcrest.object.instanceOf;

	import robotlegs.bender.extensions.commandCenter.impl.payload.FieldPayloadExtractionPoint;
	import robotlegs.bender.extensions.commandCenter.impl.payload.IPayloadExtractionPoint;
	import robotlegs.bender.extensions.commandCenter.impl.payload.MethodPayloadExtractionPoint;
	import robotlegs.bender.extensions.commandCenter.impl.payload.PayloadDescription;
	import robotlegs.bender.extensions.commandCenter.support.ExtractableGetterObject;
	import robotlegs.bender.extensions.commandCenter.support.ExtractableMethodObject;
	import robotlegs.bender.extensions.commandCenter.support.ExtractablePropertyObject;
	import robotlegs.bender.extensions.commandCenter.support.IPayload;
	import robotlegs.bender.extensions.commandCenter.support.PayloadCarrierObject;
	import robotlegs.bender.extensions.eventCommandMap.support.OrderedExtractionPointsEvent;

	public class PayloadCollectorTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var subject:PayloadCollector;

		private var extractedPropertyDescription:IPayloadExtractionPoint;

		private var extractedGetterDescription:IPayloadExtractionPoint;

		private var extractedMethodDescription:IPayloadExtractionPoint;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			subject = new PayloadCollector();
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function collects_payload():void
		{
			const p1:String = 'payload';
			const p2:Object = {};
			var payload:CommandPayload = subject.collectPayload(new PayloadCarrierObject(p1, p2));
			assertThat(payload.values, array(p1, p2));
		}

		[Test]
		public function parseDescriptionFromInstance_returns_descriptor():void
		{
			assertThat(subject.describeExtractionsForInstance({}), instanceOf(PayloadDescription));
		}

		[Test]
		public function parses_properties():void
		{
			const description:PayloadDescription = subject.describeExtractionsForInstance(new ExtractablePropertyObject());
			const point:IPayloadExtractionPoint = description.extractionPoints[0];
			assertThat(point.memberName, equalTo('extractTaggedProperty'));
			assertThat(point.valueType, equalTo(String));
			assertThat(point, instanceOf(FieldPayloadExtractionPoint));
		}

		[Test]
		public function parses_getters():void
		{
			const description:PayloadDescription = subject.describeExtractionsForInstance(new ExtractableGetterObject());
			const point:IPayloadExtractionPoint = description.extractionPoints[0];
			assertThat(point.memberName, equalTo('extractTaggedGetter'));
			assertThat(point.valueType, equalTo(Object));
			assertThat(point, instanceOf(FieldPayloadExtractionPoint));
		}

		[Test]
		public function parses_methods():void
		{
			const description:PayloadDescription = subject.describeExtractionsForInstance(new ExtractableMethodObject());
			const point:IPayloadExtractionPoint = description.extractionPoints[0];
			assertThat(point.memberName, equalTo('extractTaggedMethod'));
			assertThat(point.valueType, equalTo(IPayload));
			assertThat(point, instanceOf(MethodPayloadExtractionPoint));
		}

		[Test(expects="robotlegs.bender.extensions.commandCenter.api.PayloadCollectorError")]
		public function setter_throws_error():void
		{
			subject.describeExtractionsForInstance(new ExtractSetterObject());
			// note: no assertion. we just want to know if an error is thrown
		}

		[Test(expects="robotlegs.bender.extensions.commandCenter.api.PayloadCollectorError")]
		public function method_with_parameters_throws_error():void
		{
			subject.describeExtractionsForInstance(new ExtractMethodWithParametersObject());
			// note: no assertion. we just want to know if an error is thrown
		}

		[Test(expects="robotlegs.bender.extensions.commandCenter.api.PayloadCollectorError")]
		public function method_with_void_return_type_throws_error():void
		{
			subject.describeExtractionsForInstance(new ExtractMethodWithVoidReturnTypeObject());
			// note: no assertion. we just want to know if an error is thrown
		}

		[Test]
		public function points_are_ordered_when_tagged_with_order():void
		{
			const description:PayloadDescription = subject.describeExtractionsForInstance(new OrderedExtractionPointsEvent());
			const p0:IPayloadExtractionPoint = description.extractionPoints[0];
			const p1:IPayloadExtractionPoint = description.extractionPoints[1];
			const p2:IPayloadExtractionPoint = description.extractionPoints[2];
			assertThat(p0.memberName, equalTo('extractTaggedProperty'));
			assertThat(p1.memberName, equalTo('extractTaggedMethod'));
			assertThat(p2.memberName, equalTo('extractTaggedGetter'));
		}
	}
}

class ExtractSetterObject
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	[Payload]
	public function set extractSetter(value:String):void
	{

	}
}

class ExtractMethodWithParametersObject
{

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	[Payload]
	public function methodWithParameters(p1:String, p2:Object):int
	{
		return 0;
	}
}

class ExtractMethodWithVoidReturnTypeObject
{

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	[Payload]
	public function methodWithVoidReturnType():void
	{
	}
}
