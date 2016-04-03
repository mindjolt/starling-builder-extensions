package starlingbuilder.extensions.uicomponents
{
    import starling.display.Quad;
    /**
     *颜色渐变的quad
     *author WG
     *2016-3-7
     */
    public class GradientQuad extends Quad
    {
        private var _topLeftColor:uint;
        private var _topRightColor:uint;
        private var _bottomLeftColor:uint;
        private var _bottomRightColor:uint;
        public function GradientQuad(width:Number, height:Number, color:uint=0xffffff):void
        {
            super(width, height, color);

            _topLeftColor = _topRightColor = _bottomLeftColor = _bottomRightColor = 0xffffff;
        }
        public function set topLeftColor(value:uint):void
        {
            _topLeftColor = value;
            setVertexColor(0, value);
        }
        public function set topRightColor(value:uint):void
        {
            _topRightColor = value;
            setVertexColor(1, value);
        }
        public function set bottomLeftColor(value:uint):void
        {
            _bottomLeftColor = value;
            setVertexColor(2, value);
        }
        public function set bottomRightColor(value:uint):void
        {
            _bottomRightColor = value;
            setVertexColor(3, value);
        }
        public function get topLeftColor():uint
        {
            return _topLeftColor;
        }
        public function get topRightColor():uint
        {
            return _topRightColor;
        }
        public function get bottomLeftColor():uint
        {
            return _bottomLeftColor;
        }
        public function get bottomRightColor():uint
        {
            return _bottomRightColor;
        }
    }
}