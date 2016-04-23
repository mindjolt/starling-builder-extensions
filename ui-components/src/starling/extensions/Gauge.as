package starling.extensions
{
    import flash.geom.Point;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    public class Gauge extends Sprite
    {
        private var _image:Image;
        private var _ratio:Number;

        public function Gauge(texture:Texture)
        {
            _ratio = 1.0;
            _image = new Image(texture);

            addChild(_image);
        }

        private function update():void
        {
            _image.scaleX = _ratio;
            _image.setTexCoords(1, _ratio, 0);
            _image.setTexCoords(3, _ratio, 1);
        }

        public function get ratio():Number { return _ratio; }
        public function set ratio(value:Number):void
        {
            _ratio = value > 1 ? 1 : (value < 0 ? 0 : value);
            update();
        }
    }
}
