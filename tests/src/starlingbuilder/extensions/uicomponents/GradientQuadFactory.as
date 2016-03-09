package starlingbuilder.extensions.uicomponents
{
	import starling.display.DisplayObject;

	/**
	 *author WG
	 *2016-3-9
	 */
	public class GradientQuadFactory implements IDisplayObjectFactory
	{
		public function create():DisplayObject
		{
			return new GradientQuad(150, 150);
		}
	}
}