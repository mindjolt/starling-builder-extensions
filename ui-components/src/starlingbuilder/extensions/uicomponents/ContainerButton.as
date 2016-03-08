/**
 * Created by hyh on 6/8/15.
 */
package starlingbuilder.extensions.uicomponents
{
    import flash.geom.Rectangle;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    /** Dispatched when the user triggers the button. Bubbles. */
    [Event(name="triggered", type="starling.events.Event")]

    /** A simple button composed of an image and, optionally, text.
     *
     *  <p>You can pass a texture for up- and downstate of the button. If you do not provide a down
     *  state, the button is simply scaled a little when it is touched.
     *  In addition, you can overlay a text on the button. To customize the text, almost the
     *  same options as those of text fields are provided. In addition, you can move the text to a
     *  certain position with the help of the <code>textBounds</code> property.</p>
     *
     *  <p>To react on touches on a button, there is special <code>triggered</code>-event type. Use
     *  this event instead of normal touch events - that way, users can cancel button activation
     *  by moving the mouse/finger away from the button before releasing.</p>
     */
    public class ContainerButton extends DisplayObjectContainer
    {
        protected static const MAX_DRAG_DIST:Number = 50;

        private static var sRect:Rectangle = new flash.geom.Rectangle();

        protected var mScaleWhenDown:Number;
        private var mAlphaWhenDisabled:Number;
        protected var mEnabled:Boolean;
        protected var mIsDown:Boolean;
        protected var mUseHandCursor:Boolean;

        protected var mOriginalX:Number;
        protected var mOriginalY:Number;
        protected var mOriginalScaleX:Number;
        protected var mOriginalScaleY:Number;

        /** Creates a button with textures for up- and down-state or text. */
        public function ContainerButton()
        {
            mScaleWhenDown = 0.9;
            mAlphaWhenDisabled = 0.5;
            mEnabled = true;
            mIsDown = false;
            mUseHandCursor = true;

            mOriginalScaleX = 0;
            mOriginalScaleY = 0;
            mOriginalScaleX = 1;
            mOriginalScaleY = 1;

            addEventListener(TouchEvent.TOUCH, onTouch);

            this.touchGroup = false;
        }

        protected function resetContents():void
        {
            mIsDown = false;

            if (scaleWhenDown != 1)
            {
                x = mOriginalX;
                y = mOriginalY;

                scaleX = mOriginalScaleX;
                scaleY = mOriginalScaleY;
            }
        }

        protected function onTouch(event:TouchEvent):void
        {
            Mouse.cursor = (mUseHandCursor && mEnabled && event.interactsWith(this)) ?
                    MouseCursor.BUTTON : MouseCursor.AUTO;

            var touch:Touch = event.getTouch(this);
            if (!mEnabled || touch == null) return;

            if (touch.phase == TouchPhase.BEGAN && !mIsDown)
            {
                mOriginalScaleX = scaleX;
                mOriginalScaleY = scaleY;

                scaleX *= mScaleWhenDown;
                scaleY *= mScaleWhenDown;

                mOriginalX = x;
                mOriginalY = y;

                getBounds(parent, sRect);
                var midX:Number = sRect.x + sRect.width * 0.5;
                var midY:Number = sRect.y + sRect.height * 0.5;
                x += (1.0 - mScaleWhenDown) * (midX - x);
                y += (1.0 - mScaleWhenDown) * (midY - y);
                mIsDown = true;
            }
            else if (touch.phase == TouchPhase.MOVED && mIsDown)
            {
                // reset button when user dragged too far away after pushing
                var buttonRect:Rectangle = getBounds(stage);
                if (touch.globalX < buttonRect.x - MAX_DRAG_DIST ||
                        touch.globalY < buttonRect.y - MAX_DRAG_DIST ||
                        touch.globalX > buttonRect.x + buttonRect.width + MAX_DRAG_DIST ||
                        touch.globalY > buttonRect.y + buttonRect.height + MAX_DRAG_DIST)
                {
                    resetContents();
                }
            }
            else if (touch.phase == TouchPhase.ENDED && mIsDown)
            {
                resetContents();
                dispatchEventWith(Event.TRIGGERED, true);
            }
        }

        /** The scale factor of the button on touch. Per default, a button with a down state
         * texture won't scale. */
        public function get scaleWhenDown():Number
        { return mScaleWhenDown; }

        public function set scaleWhenDown(value:Number):void { mScaleWhenDown = value; }

        /** The alpha value of the button when it is disabled. @default 0.5 */
        public function get alphaWhenDisabled():Number
        { return mAlphaWhenDisabled; }

        public function set alphaWhenDisabled(value:Number):void { mAlphaWhenDisabled = value; }

        /** Indicates if the button can be triggered. */
        public function get enabled():Boolean
        { return mEnabled; }

        public function set enabled(value:Boolean):void
        {
            if (mEnabled != value)
            {
                mEnabled = value;
                alpha = value ? 1.0 : mAlphaWhenDisabled;
            }
        }

        /** Indicates if the mouse cursor should transform into a hand while it's over the button.
         *  @default true */
        public override function get useHandCursor():Boolean
        { return mUseHandCursor; }

        public override function set useHandCursor(value:Boolean):void { mUseHandCursor = value; }
    }
}
