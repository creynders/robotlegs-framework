package robotlegs.bender.extensions.commandCenter.impl.payload
{
	import robotlegs.bender.extensions.commandCenter.impl.CommandPayload;

	public function createPayloadFromDescription( description : PayloadDescription, carrier : Object ) : CommandPayload
	{
		var payload : CommandPayload;
		if (description.numPoints > 0)
		{
			payload = new CommandPayload();
			for ( var i : int = 0; i < description.numPoints; i++)
			{
				var extractionPoint:IPayloadExtractionPoint = description.extractionPoints[i];
				payload.addPayload(extractionPoint.extractFrom(carrier), extractionPoint.valueType);
			}
		}
		return payload;
	}
}