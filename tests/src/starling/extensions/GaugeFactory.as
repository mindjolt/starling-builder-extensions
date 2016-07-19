/**
 * Created by hyh on 4/20/16.
 */
package starling.extensions
{
    import starling.display.DisplayObject;

    import starlingbuilder.extensions.uicomponents.AbstractDisplayObjectFactory;

    public class GaugeFactory extends AbstractDisplayObjectFactory
    {
        override public function create():DisplayObject
        {
            return new Gauge(TestApp.texture);
        }
    }
}