package starlingbuilder.extensions.uicomponents
{
	import starling.display.DisplayObject;
    import starling.utils.Color;

    /**
	 *author WG
	 *2016-3-9
	 */
	public class GradientQuadFactory implements IDisplayObjectFactory
	{
		public function create():DisplayObject
		{
			var quad:GradientQuad = new GradientQuad(150, 150);
            quad.topLeftColor = Color.WHITE;
            quad.topRightColor = Color.RED;
            quad.bottomLeftColor = Color.GREEN;
            quad.bottomRightColor = Color.BLUE;
            return quad;
		}
	}
}