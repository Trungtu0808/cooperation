package com.cooperation.app

import android.util.Log
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.GetTokenResult
import com.google.firebase.auth.OAuthCredential
import com.google.firebase.auth.OAuthProvider
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

//class MainActivity: FlutterActivity() {
//}
//The FragmentActivity class adds a couple of new methods to ensure compatibility with older versions of Android,
//but other than that, there really isn't much of a difference between the two.
class MainActivity: FlutterFragmentActivity() {

    //private  val channel = "COOPERATION_CHANNEL"
    private  val signInAppleChannel = "APPLE_COOPERATION_CHANNEL"
    private val  TAG = MainActivity::class.java.simpleName

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, signInAppleChannel).setMethodCallHandler { call, result ->
            if (call.method == "signInWithApple"){
                val auth = FirebaseAuth.getInstance()
                val provider = OAuthProvider.newBuilder("apple.com")
                provider.scopes = arrayOf("email", "name").toMutableList()
                val pending = auth.pendingAuthResult

                if (pending != null){
                    pending.addOnSuccessListener{ authResult ->
                        Log.d(TAG, "checkPending:onSuccess")
                        val user = authResult.user
                        auth.getAccessToken(false).addOnSuccessListener { tokenRs ->
                            result.success((tokenRs as GetTokenResult).token)
                        }.addOnFailureListener { e ->
                            Log.w(TAG, "getAccessToken:onFailure", e)
                            result.error("getAccessToken:onFailure", e.toString(), e.toString())
                        }
                    }.addOnFailureListener { e ->
                        Log.w(TAG, "checkPending:onFailure", e)
                        result.error("checkPending:onFailure", e.toString(), e.toString())
                    }
                } else {
                    Log.d(TAG, "pending: null")
                    auth.startActivityForSignInWithProvider(this, provider.build()).addOnSuccessListener{ authResult ->
                        // Sign-In successful
                        Log.d(TAG, "activitySignIn:onSuccess")
                        result.success((authResult.credential as OAuthCredential).accessToken)
                    }.addOnFailureListener { e ->
                        Log.e(TAG, "activitySignIn:onFailure", e)
                        result.error("activitySignIn:onFailure", e.toString(), e.toString())
                    }
                }
            }
        }
    }

}