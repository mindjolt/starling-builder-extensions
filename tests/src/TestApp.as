/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package {
    import com.sgn.uicomponents.IDisplayObjectFactory;
    import com.sgn.uicomponents.ImageFactory;

    import feathers.controls.LayoutGroup;
    import feathers.core.IFeathersControl;
    import feathers.layout.AnchorLayout;
    import feathers.themes.TestGameMobileTheme;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.display.Stage;
    import starling.events.Event;
    import starling.events.ResizeEvent;
    import starling.textures.Texture;

    import starlingbuilder.editor.data.TemplateData;
    import starlingbuilder.editor.themes.IUIEditorThemeMediator;
    import starlingbuilder.editor.themes.MetalWorksDesktopTheme2;
    import starlingbuilder.engine.util.ParamUtil;
    import starlingbuilder.util.feathers.FeathersUIUtil;
    import starlingbuilder.util.ui.inspector.PropertyPanel;

    public class TestApp extends LayoutGroup implements IUIEditorThemeMediator
    {
        [Embed(source="boostslot_bg_green.png")]
        public static const TEXTURE:Class;

        [Embed(source="generic_gift.png")]
        public static const ICON:Class;

        private var _stage:Stage;
        private var _texture:Texture;
        private var _icon:Texture;
        private var _object:DisplayObject;
        private var _container:Sprite;
        private var _propertyPanel:PropertyPanel;

        public function TestApp()
        {
            super();

            _stage = Starling.current.stage;

            width = _stage.stageWidth;
            height = _stage.stageHeight;

            layout = new AnchorLayout();

            _stage.addEventListener(Event.RESIZE, onResize);

            new MetalWorksDesktopTheme2(this);
            new TestGameMobileTheme(this);

            _texture = Texture.fromBitmap(new TEXTURE);
            _icon = Texture.fromBitmap(new ICON);

            _container = new Sprite();
            _container.x = 200;
            _container.y = 200;
            addChild(_container);

            createDisplayObject();
            createPropertyPanel();
        }

        /**
         * Create ui component you would like to test here
         */
        private function createDisplayObject():void
        {
            var factory:IDisplayObjectFactory = new ImageFactory(_texture);
            _object = factory.create();
            _container.addChild(_object);
        }

        private function createPropertyPanel():void
        {
            TemplateData.load(new EmbeddedComponents.custom_component_template());

            _propertyPanel = new PropertyPanel();
            _propertyPanel.reloadData(_object, ParamUtil.getParams(TemplateData.editor_template, _object));
            _propertyPanel.layoutData = FeathersUIUtil.anchorLayoutData(50, NaN, NaN, 50);
            addChild(_propertyPanel);
        }

        private function onResize(event:ResizeEvent):void
        {
            width = _stage.stageWidth = Starling.current.viewPort.width = event.width;
            height = _stage.stageHeight = Starling.current.viewPort.height = event.height;
        }

        public function useGameTheme(target:IFeathersControl):Boolean
        {
            return _container.contains(target as DisplayObject);
        }
    }
}
