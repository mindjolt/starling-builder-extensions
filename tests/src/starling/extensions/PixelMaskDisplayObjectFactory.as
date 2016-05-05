/**
 * Created by hyh on 5/4/16.
 */
package starling.extensions
{
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.extensions.pixelmask.PixelMaskDisplayObject;

    import starlingbuilder.extensions.uicomponents.IDisplayObjectFactory;

    public class PixelMaskDisplayObjectFactory implements IDisplayObjectFactory
    {
        public function create():DisplayObject
        {
            var pixelMask:PixelMaskDisplayObject = new PixelMaskDisplayObject();
            pixelMask.mask = new Image(TestApp.icon);
            pixelMask.addChild(new Image(TestApp.texture));
            return pixelMask;
        }
    }
}
