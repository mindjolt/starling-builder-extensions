/**
 * Created by hyh on 3/3/16.
 */
package starlingbuilder.extensions.uicomponents
{
    import starlingbuilder.extensions.uicomponents.IDisplayObjectFactory;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.events.Event;

    import starling.textures.Texture;

    import starlingbuilder.extensions.uicomponents.ContainerButton;

    public class ContainerButtonFactory implements IDisplayObjectFactory
    {
        private var _texture:Texture;
        private var _icon:Texture;

        public function ContainerButtonFactory(texture:Texture, icon:Texture)
        {
            _texture = texture;
            _icon = icon;
        }

        public function create():DisplayObject
        {
            var button:ContainerButton = new ContainerButton();
            button.addEventListener(Event.TRIGGERED, onClick);
            button.addChild(new Image(_texture));
            button.addChild(new Image(_icon));
            return button;
        }

        private function onClick(event:Event):void
        {
            trace("on click");
        }
    }
}
