/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package {
    import flash.display.Sprite;
    import flash.events.Event;
    import starling.core.Starling;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    [SWF(frameRate=60, width=800, height=800, backgroundColor="#000")]
    public class Main extends Sprite
    {
        private var _starling : Starling;

        public function Main()
        {
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function _start(e:Event):void
        {
            _starling.start();
        }

        private function onEnterFrame(event:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            init();
        }

        private function init():void
        {
            Starling.handleLostContext = true;

            _starling = new Starling(TestApp, stage);

            _starling.simulateMultitouch  = false;
            _starling.enableErrorChecking = false;
            _starling.showStatsAt(HAlign.RIGHT, VAlign.TOP);
            _starling.supportHighResolutions = true;

            _starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, _start);
        }
    }
}

