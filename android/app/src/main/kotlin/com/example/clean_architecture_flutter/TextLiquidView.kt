package com.example.clean_architecture_flutter

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.view.View

class TextLiquidView(context: Context): View(context) {
    private val path = Path()
    private val wavePaint = Paint()
    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        wavePaint.color = Color.BLACK
    }

}