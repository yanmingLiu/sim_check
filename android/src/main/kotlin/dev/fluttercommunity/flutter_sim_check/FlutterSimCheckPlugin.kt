package dev.fluttercommunity.flutter_sim_check

import android.content.Context
import android.telephony.TelephonyManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterSimCheckPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel : MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "flutter_sim_check")
        context = binding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "getSimInfo") {
            val telephony = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val simState = telephony.simState
            val hasSim = simState == TelephonyManager.SIM_STATE_READY

            val carrier = telephony.networkOperatorName ?: ""
            val mccMnc = telephony.networkOperator ?: ""
            val mcc = if (mccMnc.length >= 3) mccMnc.substring(0,3) else null
            val mnc = if (mccMnc.length > 3) mccMnc.substring(3) else null

            val map: Map<String, Any?> = mapOf(
                "hasSimCard" to hasSim,
                "carrierName" to if (carrier.isNotEmpty()) carrier else null,
                "mcc" to mcc,
                "mnc" to mnc
            )
            result.success(map)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
