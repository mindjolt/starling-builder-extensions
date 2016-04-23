/**
 * Created by hyh on 4/20/16.
 */
package starling.extensions
{
    import starling.display.DisplayObject;

    import starlingbuilder.extensions.uicomponents.IDisplayObjectFactory;

    public class GaugeFactory implements IDisplayObjectFactory
    {
        public function create():DisplayObject
        {
            return new Gauge(TestApp.texture);
        }
    }
}