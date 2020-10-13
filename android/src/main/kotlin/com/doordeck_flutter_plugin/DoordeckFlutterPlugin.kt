package com.doordeck_flutter_plugin

import android.content.Context
import android.nfc.NfcManager
import androidx.annotation.NonNull
import com.doordeck.sdk.common.events.UnlockCallback
import com.doordeck.sdk.common.manager.Doordeck
import com.doordeck.sdk.common.manager.ScanType
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class DoordeckFlutterPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var doordeck: Doordeck? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "doordeck_flutter_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            SHOW_UNLOCK_CALL -> showUnlock(result)
            UPDATE_TOKEN_CALL -> updateToken(call, result)
            LOGOUT_CALL -> logout(result)
            INIT_CALL -> initDoordeck(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun initDoordeck(call: MethodCall, result: Result) {
        // @required authToken: String
        val authToken = call.argumentAt<String>(0) ?: return result.sendCallError(0, INIT_CALL, String::class.toString())
        // @required darkMode: Boolean (although we're defaulting it in Flutter as false)
        val darkMode = call.argumentAt<Boolean>(1) ?: return result.sendCallError(0, INIT_CALL, Boolean::class.toString())

        doordeck = Doordeck.initialize(
                ctx = context,
                authToken = authToken,
                darkMode = darkMode
        )
    }

    private fun logout(result: Result) {
        return doordeck?.logout() ?: result.sendInitializationError()
    }

    private fun showUnlock(result: Result) {
        val scanType = (context.getSystemService(Context.NFC_SERVICE) as? NfcManager)
                ?.defaultAdapter
                ?.takeIf { return@takeIf it.isEnabled }
                ?.let { return@let ScanType.NFC }
                ?: ScanType.QR

        return doordeck?.showUnlock(
                context = context,
                type = scanType,
                callback = unlockCallBack
        )
                ?: result.sendInitializationError()
    }

    private fun updateToken(call: MethodCall, result: Result) {
        // @required authToken: String
        val authToken = call.argumentAt<String>(0) ?: return result.sendCallError(0, UPDATE_TOKEN_CALL, String::class.toString())

        return doordeck
                ?.updateToken(
                        authToken = authToken,
                        ctx = context
                ) ?: result.sendInitializationError()
    }


    companion object {
        private const val SHOW_UNLOCK_CALL = "showUnlock"
        private const val UPDATE_TOKEN_CALL = "updateToken"
        private const val LOGOUT_CALL = "logout"
        private const val INIT_CALL = "initDoordeck"

        private const val INVALID_AUTH_TOKEN_CALLBACK = "invalidAuthToken"
        private const val NOT_AUTHENTICATED_CALLBACK = "notAuthenticated"
        private const val UNLOCK_FAILED_CALLBACK = "unlockFailed"
        private const val UNLOCK_SUCCESS_CALLBACK = "unlockSuccess"
        private const val VERIFICATION_NEEDED_CALLBACK = "verificationNeeded"

        private const val MISMATCH_METHOD_CALL = "MISMATCH_METHOD_CALL"
        private const val INITIALIZATION_ERROR = "INITIALIZATION_ERROR"
    }

    private fun <T> MethodCall.argumentAt(position: Int): T? {
        @Suppress("UNCHECKED_CAST")
        return (arguments as? List<Any?>)?.getOrNull(position) as? T
    }

    private fun Result.sendCallError(argumentPosition: Int, methodName: String, classExpected: String) {
        return error(
                MISMATCH_METHOD_CALL,
                "Impossible calling $methodName with a class $classExpected in the position $argumentPosition",
                null
        )
    }

    private fun Result.sendInitializationError() {
        return error(
                INITIALIZATION_ERROR,
                "Trying to access to the Doordeck instance without initializing it first (through $INIT_CALL)",
                null
        )
    }

    /// ===== UNLOCK CALLBACK
    private val unlockCallBack: UnlockCallback = object: UnlockCallback {
        override fun invalidAuthToken() {
            channel.invokeMethod(INVALID_AUTH_TOKEN_CALLBACK, null)
        }

        override fun notAuthenticated() {
            channel.invokeMethod(NOT_AUTHENTICATED_CALLBACK, null)
        }

        override fun unlockFailed() {
            channel.invokeMethod(UNLOCK_FAILED_CALLBACK, null)
        }

        override fun unlockSuccess() {
            channel.invokeMethod(UNLOCK_SUCCESS_CALLBACK, null)
        }

        override fun verificationNeeded() {
            channel.invokeMethod(VERIFICATION_NEEDED_CALLBACK, null)
            doordeck?.showVerificationScreen(context)
        }
    }
}
