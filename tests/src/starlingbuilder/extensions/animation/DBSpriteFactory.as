/**
 * Created by hyh on 7/25/16.
 */
package starlingbuilder.extensions.animation
{
    import starling.display.DisplayObject;

    import starlingbuilder.editor.controller.ComponentRenderSupport;
    import starlingbuilder.extensions.uicomponents.AbstractDisplayObjectFactory;

    public class DBSpriteFactory extends AbstractDisplayObjectFactory
    {
        override public function create():DisplayObject
        {
            var sprite:DBSprite = new DBSprite(ComponentRenderSupport.support.assetMediator);
            sprite.y = 250;
            sprite.armatureName = "Dragon";
            sprite.animationName = "walk";
            sprite.autoPlay = true;
            return sprite;
        }
    }
}
