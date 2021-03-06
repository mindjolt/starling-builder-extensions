/**
 * Created by hyh on 9/29/15.
 */
package
{
    import flash.display.Sprite;

    import starling.extensions.Gauge;

    import starling.extensions.pixelmask.PixelMaskDisplayObject;

    import starlingbuilder.extensions.animation.DBAssetMediator;

    import starlingbuilder.extensions.animation.DBSprite;

    import starlingbuilder.extensions.particle.FFParticleSprite;

    import starlingbuilder.extensions.uicomponents.ContainerButton;
    import starlingbuilder.extensions.uicomponents.GradientQuad;

    public class EmbeddedComponents extends Sprite
    {
        [Embed(source="custom_component_template.json", mimeType="application/octet-stream")]
        public static const custom_component_template:Class;

        public static const linkers:Array = [PixelMaskDisplayObject, ContainerButton, GradientQuad, Gauge, FFParticleSprite, DBSprite, DBAssetMediator];
    }
}
