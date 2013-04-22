//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl.payload
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import robotlegs.bender.framework.api.ILogger;

	public class PayloadReflector
	{

		/*============================================================================*/
		/* Private Static Properties                                                  */
		/*============================================================================*/

		private static const TAG_OF_INTEREST:String = 'Payload';

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function describeExtractionsForClass(type:Class):PayloadDescription
		{
			const factoryDescription:XML = describeType(type).factory[0];
			return parseExtractionPoints(factoryDescription);
		}

		public function describeExtractionsForInstance(instance:Object):PayloadDescription
		{
			return parseExtractionPoints(describeType(instance));
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function parseExtractionPoints(rawDescription:XML):PayloadDescription
		{
			const payloadDescription:PayloadDescription = new PayloadDescription();
			parsePropertyExtractionPoints(rawDescription, payloadDescription);
			parseAccessorExtractionPoints(rawDescription, payloadDescription);
			parseMethodExtractionPoints(rawDescription, payloadDescription);
			payloadDescription.sortPoints();
			return payloadDescription;
		}

		private function parseMethodExtractionPoints(rawDescription:XML, payloadDescription:PayloadDescription):void
		{
			for each (var extractTag:XML in rawDescription.method.metadata.(@name == TAG_OF_INTEREST))
			{
				const memberDescription:XML = extractTag.parent();
				const memberName:String = memberDescription.attribute('name');

				if (memberDescription.parameter.length() > 0)
					throw new PayloadReflectorError('Methods with parameters are not extractable '
						+ rawDescription.attribute('name') + '#' + memberName);

				const valueType:String = memberDescription.attribute('returnType');
				if (valueType == 'void')
					throw new PayloadReflectorError('Methods without return type are not extractable '
						+ rawDescription.attribute('name') + '#' + memberName);

				payloadDescription.addExtractionPoint(new MethodPayloadExtractionPoint(
					memberName,
					getDefinitionByName(valueType) as Class,
					getOrdinal(extractTag)));
			}
		}

		private function parseAccessorExtractionPoints(rawDescription:XML, payloadDescription:PayloadDescription):void
		{
			for each (var extractTag:XML in rawDescription.accessor.metadata.(@name == TAG_OF_INTEREST))
			{
				const memberDescription:XML = extractTag.parent();
				const memberName:String = memberDescription.attribute('name');

				if (memberDescription.hasOwnProperty('@access') && memberDescription.attribute('access') == 'writeonly')
					throw new PayloadReflectorError('Setters are not extractable '
						+ rawDescription.attribute('name') + '#' + memberName);

				payloadDescription.addExtractionPoint(new FieldPayloadExtractionPoint(
					memberName,
					getDefinitionByName(memberDescription.attribute('type')) as Class,
					getOrdinal(extractTag)));
			}
		}

		private function parsePropertyExtractionPoints(rawDescription:XML, payloadDescription:PayloadDescription):void
		{
			for each (var extractTag:XML in rawDescription.variable.metadata.(@name == TAG_OF_INTEREST))
			{
				const memberDescription:XML = extractTag.parent();
				payloadDescription.addExtractionPoint(new FieldPayloadExtractionPoint(
					memberDescription.attribute('name'),
					getDefinitionByName(memberDescription.attribute('type')) as Class,
					getOrdinal(extractTag)));
			}
		}

		private function getOrdinal(extractTag:XML):Number
		{
			const ordinal:Number = parseInt(extractTag.arg.(@key == 'order').@value);
			return isNaN(ordinal) ? 0 : ordinal;
		}
	}
}
