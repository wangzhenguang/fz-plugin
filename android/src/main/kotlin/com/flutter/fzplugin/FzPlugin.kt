package com.flutter.fzplugin

import android.content.Context
import android.view.Gravity
import android.widget.Toast
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar

class FzPlugin(var context: Context) : MethodCallHandler {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "fz_plugin")
            channel.setMethodCallHandler(FzPlugin(registrar.context()))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {

        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "toast" -> {
                // 3个参数 msg length gravity
                val msg = call.argument<String>("msg")
                val length = call.argument<String>("length")
                val gravity = call.argument<String>("gravity")

                val toast = Toast.makeText(context,
                        msg,
                        if ("long" == length) Toast.LENGTH_LONG else Toast.LENGTH_SHORT)

                if (gravity == "bottom") {
                    toast.setGravity(Gravity.BOTTOM, 0, 100)
                } else {
                    toast.setGravity(Gravity.CENTER, 0, 0)
                }

                toast.show()
                result.success("success")
            }
            else -> result.notImplemented()

        }
    }
}
