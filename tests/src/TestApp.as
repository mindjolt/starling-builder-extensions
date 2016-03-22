/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package {

    import feathers.controls.LayoutGroup;
    import feathers.core.IFeathersControl;
    import feathers.layout.AnchorLayout;
    import feathers.themes.TestGameMobileTheme;

    import flash.utils.Dictionary;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.display.Stage;
    import starling.events.Event;
    import starling.events.ResizeEvent;
    import starling.textures.Texture;
    import starling.utils.AssetManager;

    import starlingbuilder.editor.controller.ComponentRenderSupport;

    import starlingbuilder.editor.data.TemplateData;
    import starlingbuilder.editor.helper.AssetMediator;
    import starlingbuilder.editor.themes.IUIEditorThemeMediator;
    import starlingbuilder.editor.themes.MetalWorksDesktopTheme2;
    import starlingbuilder.editor.ui.AbstractPropertyPopup;
    import starlingbuilder.editor.ui.AssetTab;
    import starlingbuilder.editor.ui.DefaultEditPropertyPopup;
    import starlingbuilder.editor.ui.DisplayObjectPropertyPopup;
    import starlingbuilder.editor.ui.ImageGridPopup;
    import starlingbuilder.editor.ui.ScaleTextureConstructorPopup1;
    import starlingbuilder.editor.ui.TextureConstructorPopup;
    import starlingbuilder.editor.ui.TexturePropertyPopup;
    import starlingbuilder.engine.IAssetMediator;
    import starlingbuilder.engine.IUIBuilder;
    import starlingbuilder.engine.UIBuilder;
    import starlingbuilder.engine.util.ParamUtil;
    import starlingbuilder.extensions.uicomponents.ContainerButtonFactory;
    import starlingbuilder.extensions.uicomponents.ImageFactory;
    import starlingbuilder.util.feathers.FeathersUIUtil;
    import starlingbuilder.util.ui.inspector.PropertyPanel;

    public class TestApp extends LayoutGroup implements IUIEditorThemeMediator
    {
        [Embed(source="boostslot_bg_green.png")]
        public static const TEXTURE:Class;

        [Embed(source="generic_gift.png")]
        public static const ICON:Class;

        public static var texture:Texture;
        public static var icon:Texture;

        private static const LINKERS:Array = [DefaultEditPropertyPopup, DisplayObjectPropertyPopup, TexturePropertyPopup, TextureConstructorPopup, ImageGridPopup];

        /**
         * Replace UI factory you would like to test here
         */
        public static const SINGLE_COMPONENT:Class = ImageFactory;

        public static const ALL_COMPONENTS:Array = [ImageFactory, ContainerButtonFactory];

        public static var TEST_ALL:Boolean = false;

        private var _stage:Stage;
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

            texture = Texture.fromBitmap(new TEXTURE);
            icon = Texture.fromBitmap(new ICON);

            setupComponentRenderSupport();

            _container = new Sprite();
            _container.x = 200;
            _container.y = 200;
            addChild(_container);

            createPropertyPanel();

            test();
        }


        private function testSingle():void
        {
            createDisplayObject(SINGLE_COMPONENT);
        }

        private function createDisplayObject(cls:Class):void
        {
            _container.removeChildren(0, -1, true);
            _object = new cls().create();
            _container.addChild(_object);
            _propertyPanel.reloadData(_object, ParamUtil.getParams(TemplateData.editor_template, _object));
        }

        private function createPropertyPanel():void
        {
            TemplateData.load(new EmbeddedComponents.custom_component_template());

            _propertyPanel = new PropertyPanel();

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

        private function setupComponentRenderSupport():void
        {
            var assetManager:AssetManager = new AssetManager();
            assetManager.addTexture("texture", texture);
            assetManager.addTexture("icon", icon);
            AssetTab.assetList = assetManager.getTextureNames();
            var mediator:IAssetMediator = new AssetMediator(assetManager);
            var uiBuilder:IUIBuilder = new UIBuilder(mediator, true);
            ComponentRenderSupport.support = new ComponentRenderSupport(mediator, new Dictionary(), uiBuilder);
        }

        private function test():void
        {
            if (TEST_ALL)
                testAll();
            else
                testSingle();
        }

        private function testAll(id:int = 0):void
        {
            createDisplayObject(ALL_COMPONENTS[id]);

            if (++id < ALL_COMPONENTS.length)
            {
                Starling.current.juggler.delayCall(function():void{
                    testAll(id);
                }, 0.5);
            }
        }
    }
}
