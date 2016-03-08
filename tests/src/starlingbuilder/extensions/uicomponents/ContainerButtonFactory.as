/**
 * Created by hyh on 3/3/16.
 */
package starlingbuilder.extensions.uicomponents
{
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.events.Event;

    public class ContainerButtonFactory implements IDisplayObjectFactory
    {
        public function create():DisplayObject
        {
            var button:ContainerButton = new ContainerButton();
            button.addEventListener(Event.TRIGGERED, onClick);
            button.addChild(new Image(TestApp.texture));
            button.addChild(new Image(TestApp.icon));
            return button;
        }

        private function onClick(event:Event):void
        {
            trace("on click");
        }
    }
}
