/**
 * Created by hyh on 3/3/16.
 */
package starlingbuilder.extensions.uicomponents
{
    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.events.Event;

    public class ContainerButtonFactory extends AbstractDisplayObjectFactory
    {
        override public function create():DisplayObject
        {
            var button:ContainerButton = new ContainerButton();
            button.addEventListener(Event.TRIGGERED, onClick);
            var img1:Image = new Image(TestApp.texture);
            var img2:Image = new Image(TestApp.icon);
            img1.y = img2.y = 100;
            button.addChild(img1);
            button.addChild(img2);
            button.alignPivot();
            Starling.juggler.tween(button, 1, {"scaleX":0.9, "scaleY":0.9, "repeatCount":0, "reverse":true});
            return button;
        }

        private function onClick(event:Event):void
        {
            trace("on click");
        }
    }
}
