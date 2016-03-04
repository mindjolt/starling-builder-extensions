/**
 * Created by hyh on 9/29/15.
 */
package
{
    import flash.display.Sprite;

    import starling.extensions.pixelmask.PixelMaskDisplayObject;

    import starlingbuilder.extensions.uicomponents.ContainerButton;

    public class EmbeddedComponents extends Sprite
    {
        [Embed(source="custom_component_template.json", mimeType="application/octet-stream")]
        public static const custom_component_template:Class;

        public static const linkers:Array = [PixelMaskDisplayObject, ContainerButton];
    }
}
