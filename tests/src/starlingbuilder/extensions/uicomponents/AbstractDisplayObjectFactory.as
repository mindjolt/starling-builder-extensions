/**
 * Created by hyh on 7/19/16.
 */
package starlingbuilder.extensions.uicomponents
{
    import starling.display.DisplayObject;

    public class AbstractDisplayObjectFactory implements IDisplayObjectFactory
    {
        public function create():DisplayObject
        {
            return null;
        }

        public function get customParams():Object
        {
            return {
                cls:"",
                constructorParams:[],
                params:{},
                customParams:{}
            };
        }
    }

}
