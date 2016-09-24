/**
 * Created by hyh on 9/23/16.
 */
package starling.extensions
{
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.extensions.lighting.LightSource;
    import starling.extensions.lighting.LightStyle;
    import starling.textures.Texture;

    import starlingbuilder.extensions.uicomponents.AbstractDisplayObjectFactory;

    public class LightingFactory extends AbstractDisplayObjectFactory
    {
        [Embed(source="character.png")]
        public static const CHARACTER:Class;

        [Embed(source="character_n.png")]
        public static const CHARACTER_N:Class;

        override public function create():DisplayObject
        {
            var sprite:Sprite = new Sprite();
            var character:Image = new Image(Texture.fromBitmap(new CHARACTER()));
            character.style = new LightStyle(Texture.fromBitmap(new CHARACTER_N()));
            character.x = character.y = 50;
            sprite.addChild(character);
            sprite.addChild(new LightSource(LightSource.TYPE_POINT, 0xffff00));
            sprite.addChild(new LightSource(LightSource.TYPE_AMBIENT, 0x0000ff));
            return sprite;
        }
    }
}
