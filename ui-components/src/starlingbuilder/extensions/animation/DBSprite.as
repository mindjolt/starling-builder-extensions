/**
 * Created by hyh on 7/25/16.
 */
package starlingbuilder.extensions.animation
{
    import dragonBones.Armature;
    import dragonBones.animation.WorldClock;
    import dragonBones.factories.StarlingFactory;

    import starling.display.DisplayObject;

    import starling.display.Sprite;

    import starlingbuilder.engine.IAssetMediator;

    public class DBSprite extends Sprite
    {
        public static const STARLING_FACTORY:String = "starlingFactory";
        public static const WORLD_CLOCK:String = "worldClock";

        protected var _assetMediator:IAssetMediator;
        protected var _starlingFactory:StarlingFactory;
        protected var _worldClock:WorldClock;

        protected var _armatureName:String;
        protected var _animationName:String;

        protected var _armature:Armature;
        protected var _autoPlay:Boolean = true;

        public function DBSprite(assetMediator:IAssetMediator)
        {
            super();
            _assetMediator = assetMediator;
            _starlingFactory = _assetMediator.getCustomData("starlingFactory", null) as StarlingFactory;
            _worldClock = _assetMediator.getCustomData("worldClock", null) as WorldClock;
        }

        public function get armatureName():String
        {
            return _armatureName;
        }

        public function set armatureName(value:String):void
        {
            if (_armatureName != value)
            {
                _armatureName = value;
                play();
            }
        }

        public function get animationName():String
        {
            return _animationName;
        }

        public function set animationName(value:String):void
        {
            if (_animationName != value)
            {
                _animationName = value;
                play();
            }
        }

        public function get autoPlay():Boolean
        {
            return _autoPlay;
        }

        public function set autoPlay(value:Boolean):void
        {
            if (_autoPlay != value)
            {
                _autoPlay = value;
                play();
            }
        }

        public function play():void
        {
            if (_armatureName && _animationName && _autoPlay)
            {
                disposeArmature();
                createArmature();
                _armature.animation.gotoAndPlay(_animationName);
            }
        }

        protected function disposeArmature():void
        {
            if (_armature)
            {
                (_armature.display as DisplayObject).removeFromParent(true);
                _worldClock.remove(_armature);
                _armature.dispose();
                _armature = null;
            }
        }

        protected function createArmature():void
        {
            if (!_animationName) return;

            _armature = _starlingFactory.buildArmature(_armatureName);

            if (_armature)
            {
                _worldClock.add(_armature);
                addChild(_armature.display as DisplayObject);
            }
        }

        public function get armature():Armature
        {
            return _armature;
        }

        override public function dispose():void
        {
            disposeArmature();
            super.dispose();
        }
    }
}
