/**
 * Created by hyh on 9/23/16.
 */
package starling.extensions
{
    import starling.display.DisplayObject;
    import starling.extensions.lighting.LightSource;

    import starlingbuilder.extensions.uicomponents.AbstractDisplayObjectFactory;

    public class LightSourceFactory extends AbstractDisplayObjectFactory
    {
        override public function create():DisplayObject
        {
            var lightSource:LightSource = new LightSource();
            lightSource.color = 0x00ff00;
            lightSource.showLightBulb = true;
            return lightSource;
        }
    }
}
