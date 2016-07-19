/**
 * Created by hyh on 3/3/16.
 */
package starlingbuilder.extensions.uicomponents
{
    import starling.display.DisplayObject;
    import starling.display.Image;

    public class ImageFactory extends AbstractDisplayObjectFactory
    {
        override public function create():DisplayObject
        {
            return new Image(TestApp.texture);
        }
    }
}
