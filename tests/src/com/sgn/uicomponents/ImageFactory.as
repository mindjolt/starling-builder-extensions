/**
 * Created by hyh on 3/3/16.
 */
package com.sgn.uicomponents
{
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.textures.Texture;

    public class ImageFactory implements IDisplayObjectFactory
    {
        private var _texture:Texture;

        public function ImageFactory(texture:Texture)
        {
            _texture = texture;
        }

        public function create():DisplayObject
        {
            return new Image(_texture);
        }
    }
}
