/**
 * Created by hyh on 4/30/16.
 */
package starlingbuilder.extensions.particle
{
    import starling.display.DisplayObject;
    import starling.textures.Texture;

    import starlingbuilder.extensions.uicomponents.AbstractDisplayObjectFactory;

    public class FFParticleSpriteFactory extends AbstractDisplayObjectFactory
    {
        [Embed(source="default.png")]
        public static const TEXTURE:Class;

        [Embed(source="default.pex", mimeType="application/octet-stream")]
        public static const CONFIG:Class;

        override public function create():DisplayObject
        {
            var sprite:FFParticleSprite = new FFParticleSprite();
            sprite.texture = Texture.fromBitmap(new TEXTURE);
            sprite.config = XML(new CONFIG());
            sprite.particleId = "particle1";
            return sprite;
        }
    }
}
