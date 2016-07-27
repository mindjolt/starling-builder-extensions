/**
 * Created by hyh on 7/25/16.
 */
package starlingbuilder.extensions.animation
{
    import dragonBones.animation.WorldClock;
    import dragonBones.factories.StarlingFactory;
    import dragonBones.objects.DataParser;
    import dragonBones.objects.DragonBonesData;
    import dragonBones.objects.XMLDataParser;

    import flash.utils.ByteArray;

    import starling.core.Starling;
    import starling.events.Event;

    import starling.utils.AssetManager;

    import starlingbuilder.editor.helper.AssetMediator;

    public class DBAssetMediator extends AssetMediator
    {
        private var _starlingFactory:StarlingFactory;
        private var _worldClock:WorldClock;

        public function DBAssetMediator(assetManager:AssetManager)
        {
            super(assetManager);

            setupDB();
        }

        private function setupDB():void
        {
            _starlingFactory = new StarlingFactory();

            var name:String;
            var data:DragonBonesData;

            //parse texture atlas
            for each (name in _assetManager.getTextureAtlasNames())
            {
                _starlingFactory.addTextureAtlas(_assetManager.getTextureAtlas(name), name);
            }

            //parse byte array format
            for each (name in _assetManager.getByteArrayNames())
            {
                if (!_assetManager.getTextureAtlas(name)) continue;

                var ba:ByteArray = _assetManager.getByteArray(name);

                try
                {
                    data = ba.readObject() as DragonBonesData;
                }
                catch (e:Error)
                {
                    try
                    {
                        ba.uncompress();
                        data = ba.readObject() as DragonBonesData;
                    }
                    catch (e:Error) {}
                }

                if (data)
                    _starlingFactory.addSkeletonData(data, name);
            }

            //parse xml format
            for each (name in _assetManager.getXmlNames())
            {
                if (!_assetManager.getTextureAtlas(name)) continue;

                var xml:XML = _assetManager.getXml(name);

                try
                {
                    data = XMLDataParser.parseDragonBonesData(xml);
                    _starlingFactory.addSkeletonData(data, name);
                }
                catch (e:Error) {}
            }

            //parse json format
            for each (name in _assetManager.getObjectNames())
            {
                if (!_assetManager.getTextureAtlas(name)) continue;

                var object:Object = _assetManager.getObject(name);

                try
                {
                    data = DataParser.parseData(object);
                    _starlingFactory.addSkeletonData(data, name);
                }
                catch (e:Error) {}
            }

            _worldClock = new WorldClock();
            Starling.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(event:Event):void
        {
            _worldClock.advanceTime(-1);
        }

        override public function getCustomData(type:String, name:String):Object
        {
            switch (type)
            {
                case DBSprite.STARLING_FACTORY:
                    return _starlingFactory;
                case DBSprite.WORLD_CLOCK:
                    return _worldClock;
                default:
                    return null;
            }
        }
    }
}
