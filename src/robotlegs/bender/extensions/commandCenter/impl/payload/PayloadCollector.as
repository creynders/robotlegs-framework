//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.commandCenter.impl.payload
{
	import robotlegs.bender.extensions.commandCenter.impl.CommandPayload;

	public class PayloadCollector
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _payloadReflector:PayloadReflector;

		private var _description:PayloadDescription;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function PayloadCollector(carrierClass:Class = null)
		{
			_payloadReflector = new PayloadReflector();
			carrierClass && (_description = _payloadReflector.describeExtractionsForClass(carrierClass));
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function collectPayload(carrier:Object):CommandPayload
		{
			var payload:CommandPayload;
			_description ||= _payloadReflector.describeExtractionsForInstance(carrier);
			if (_description.numPoints > 0)
			{
				payload = new CommandPayload();
				for (var i:int = 0; i < _description.numPoints; i++)
				{
					var extractionPoint:IPayloadExtractionPoint = _description.extractionPoints[i];
					payload.addPayload(extractionPoint.extractFrom(carrier), extractionPoint.valueType);
				}
			}
			return payload;
		}
	}
}
