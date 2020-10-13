import Flutter
import UIKit

public class SwiftDoordeckFlutterPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "doordeck_flutter_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftDoordeckFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == SHOW_UNLOCK_CALL) {
            showUnlock(result: result)
        } else if (call.method ==  INIT_DOORDECK_CALL) {
            initDoordeck(call, result: result)
        } else if (call.method == UPDATE_TOKEN_CALL) {
            updateToken(call, result: result)
        } else if (call.method == LOGOUT_CALL) {
            // Logout not implemented in the iOS SDK
        } else {
            result(FlutterMethodNotImplemented)
        }
    }


    
    private var doordeck: Doordeck! = nil

    @objc private func initDoordeck(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let authTokenString = (call.argumentAt(0) as? String) else {
            sendCallError(
                result,
                argumentPosition: 0,
                methodName: INIT_DOORDECK_CALL,
                classExpected: "String"
            )
            return
        }

        guard let darkMode = (call.argumentAt(1) as? Bool) else {
            sendCallError(
                result,
                argumentPosition: 1,
                methodName: INIT_DOORDECK_CALL,
                classExpected: "Bool"
            )
            return
        }

        guard let closeButton = (call.argumentAt(2) as? Bool) else {
            sendCallError(
                result,
                argumentPosition: 2,
                methodName: INIT_DOORDECK_CALL,
                classExpected: "Bool"
            )
            return
        }

        let authToken = AuthTokenClass(authTokenString)
        doordeck = Doordeck(authToken, darkMode: darkMode, closeButton: closeButton)
        doordeck.delegate = self
        doordeck.Initialize()
    }

    @objc private func updateToken(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let authTokenString = (call.argumentAt(0) as? String) else {
            sendCallError(
                result,
                argumentPosition: 0,
                methodName: INIT_DOORDECK_CALL,
                classExpected: "String"
            )
            return
        }

        let authToken = AuthTokenClass(authTokenString)
        guard let doordeck = doordeck else {
            //result.sendInitializationError()
            return
        }
        doordeck.updateAuthToken(authToken)
    }

    private func showUnlock(result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            guard let doordeck = self.doordeck else {
                //result.sendInitializationError()
                return
            }

            doordeck.showUnlockScreen(success: {
                print("success")
            }, fail: {print("fail")})
        }
    }
    
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}



func sendCallError(_ flutterResult: @escaping FlutterResult, argumentPosition: Int, methodName: String, classExpected: String) {
    return flutterResult(
        FlutterError.init(
            code: MISMATCH_METHOD_CALL,
            message: "Impossible calling \(methodName) with a class \(classExpected) in the position \(argumentPosition)",
            details: nil
        )
    )
}

func sendInitializationError(_ flutterResult: @escaping FlutterResult) {
    return flutterResult(
        FlutterError.init(
            code: INITIALIZATION_ERROR,
            message: "Trying to access to the Doordeck instance without initializing it first (through \(INIT_DOORDECK_CALL))",
            details: nil
        )
    )
}




extension FlutterMethodCall {
    func argumentAt(_ position: Int) -> Any? {
        return (self.arguments as! [Any])[safe: position]
    }
}

private let SHOW_UNLOCK_CALL = "showUnlock"
private let INIT_DOORDECK_CALL = "initDoordeck"
private let UPDATE_TOKEN_CALL = "updateToken"
private let LOGOUT_CALL = "logout"

private let INVALID_AUTH_TOKEN_CALLBACK = "invalidAuthToken"
private let NOT_AUTHENTICATED_CALLBACK = "notAuthenticated"
private let UNLOCK_FAILED_CALLBACK = "unlockFailed"
private let UNLOCK_SUCCESS_CALLBACK = "unlockSuccess"
private let VERIFICATION_NEEDED_CALLBACK = "verificationNeeded"

private let MISMATCH_METHOD_CALL = "MISMATCH_METHOD_CALL"
private let INITIALIZATION_ERROR = "INITIALIZATION_ERROR"

extension SwiftDoordeckFlutterPlugin: DoordeckProtocol {
    public func authenticated() {

    }

    public func verificationNeeded() {

    }

    public func newAuthTokenRequired() -> AuthTokenClass {
      return AuthTokenClass("")
    }

    public func unlockSuccessful() {

    }

}
