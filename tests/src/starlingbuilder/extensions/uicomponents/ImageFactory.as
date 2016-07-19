/**
 * Created by hyh on 3/3/16.
 */
package starlingbuilder.extensions.uicomponents
{
    import starling.display.DisplayObject;
    import starling.display.Image;

    import starlingbuilder.engine.util.ParamUtil;

    public class ImageFactory extends AbstractDisplayObjectFactory
    {
        override public function create():DisplayObject
        {
            return new Image(TestApp.texture);
        }

        override public function get customParams():Object
        {
            return {
                cls:"",
                constructorParams:[{cls:ParamUtil.getClassName(Image), textureName:"texture"}],
                params:{},
                customParams:{}
            };
        }
    }
}
