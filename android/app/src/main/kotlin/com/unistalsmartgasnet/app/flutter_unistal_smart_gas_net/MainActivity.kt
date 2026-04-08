package com.unistalsmartgasnet.app.flutter_unistal_smart_gas_net

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.android.play.core.appupdate.AppUpdateManagerFactory
import com.google.android.play.core.install.model.UpdateAvailability

class MainActivity: FlutterActivity() {

    private val CHANNEL = "steelApp"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "getAppUpdate") {

                    val appUpdateManager = AppUpdateManagerFactory.create(this)

                    appUpdateManager.appUpdateInfo
                        .addOnSuccessListener { appUpdateInfo ->

                            val isUpdateAvailable = appUpdateInfo.updateAvailability() == UpdateAvailability.UPDATE_AVAILABLE

                            val response: HashMap<String, Any> = HashMap()
                            response["update"] = isUpdateAvailable

                            result.success(response)
                        }
                        .addOnFailureListener {
                            result.success(mapOf("update" to false))
                        }

                } else {
                    result.notImplemented()
                }
            }
    }
}