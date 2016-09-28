// =================================================================================================
//
//	Starling Framework
//	Copyright 2011-2016 Gamua. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.extensions
{
    import starling.display.Mesh;
    import starling.rendering.MeshEffect;
    import starling.rendering.VertexDataFormat;
    import starling.styles.MeshStyle;

    public class TextureMaskStyle extends MeshStyle
    {
        public static const VERTEX_FORMAT:VertexDataFormat =
            MeshStyle.VERTEX_FORMAT.extend("threshold:float1");

        private var _threshold:Number;

        public function TextureMaskStyle(threshold:Number=0.5)
        {
            _threshold = threshold;
        }

        override public function copyFrom(meshStyle:MeshStyle):void
        {
            var otherStyle:TextureMaskStyle = meshStyle as TextureMaskStyle;
            if (otherStyle) _threshold = otherStyle._threshold;

            super.copyFrom(meshStyle);
        }

        override public function createEffect():MeshEffect
        {
            return new TextureMaskEffect();
        }

        override public function get vertexFormat():VertexDataFormat
        {
            return VERTEX_FORMAT;
        }

        override protected function onTargetAssigned(target:Mesh):void
        {
            updateVertices();
        }

        private function updateVertices():void
        {
            var numVertices:int = vertexData.numVertices;
            for (var i:int=0; i<numVertices; ++i)
                vertexData.setFloat(i, "threshold", _threshold);

            setRequiresRedraw();
        }

        // properties

        public function get threshold():Number { return _threshold; }
        public function set threshold(value:Number):void
        {
            if (_threshold != value && target)
            {
                _threshold = value;
                updateVertices();
            }
        }
    }
}

import flash.display3D.Context3D;

import starling.extensions.TextureMaskStyle;
import starling.rendering.MeshEffect;
import starling.rendering.Program;
import starling.rendering.VertexDataFormat;

class TextureMaskEffect extends MeshEffect
{
    public static const VERTEX_FORMAT:VertexDataFormat = TextureMaskStyle.VERTEX_FORMAT;

    public function TextureMaskEffect()
    { }

    override protected function createProgram():Program
    {
        if (texture)
        {
            var vertexShader:String = [
                "m44 op, va0, vc0", // 4x4 matrix transform to output clip-space
                "mov v0, va1     ", // pass texture coordinates to fragment program
                "mul v1, va2, vc4", // multiply alpha (vc4) with color (va2), pass to fp
                "mov v2, va3     "  // pass threshold to fp
            ].join("\n");

            var fragmentShader:String = [
                tex("ft0", "v0", 0, texture),
                "sub ft1, ft0, v2.xxxx", // subtract threshold
                "kil ft1.w            ", // abort if alpha < 0
                "mul  oc, ft0, v1     "  // else multiply with color & copy to output buffer
            ].join("\n");

            return Program.fromSource(vertexShader, fragmentShader);
        }
        else return super.createProgram();
    }

    override protected function beforeDraw(context:Context3D):void
    {
        super.beforeDraw(context);
        if (texture) vertexFormat.setVertexBufferAt(3, vertexBuffer, "threshold");
    }

    override protected function afterDraw(context:Context3D):void
    {
        if (texture) context.setVertexBufferAt(3, null);
        super.afterDraw(context);
    }

    override public function get vertexFormat():VertexDataFormat
    {
        return VERTEX_FORMAT;
    }
}
