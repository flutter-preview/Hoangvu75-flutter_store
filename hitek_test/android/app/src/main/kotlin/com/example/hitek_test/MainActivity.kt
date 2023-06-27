package com.example.hitek_test

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi
import com.example.hitek_test.network_config.NetworkConnectivityListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(), NetworkConnectivityListener.NetworkConnectivityListenerCallback {
    private lateinit var flutterAndroidChannel: MethodChannel
    private lateinit var networkConnectivityListener: NetworkConnectivityListener

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterAndroidChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "native_android_channel",
        )
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        networkConnectivityListener = NetworkConnectivityListener(this)
        networkConnectivityListener.startListening(this)

        isOnline(this).apply {
            when (this) {
                true -> {
                    onNetworkAvailable()
                }
                false -> {
                    onNetworkLost()
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        networkConnectivityListener.stopListening()
    }

    override fun onNetworkAvailable() {
        runOnUiThread {
            flutterAndroidChannel.invokeMethod(
                "internet_connection",
                true
            )
        }
    }

    override fun onNetworkLost() {
        runOnUiThread {
            flutterAndroidChannel.invokeMethod(
                "internet_connection",
                false
            )
        }
    }

    @RequiresApi(Build.VERSION_CODES.M)
    fun isOnline(context: Context): Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val capabilities = connectivityManager.getNetworkCapabilities(connectivityManager.activeNetwork)
        if (capabilities != null) {
            if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
                return true
            } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
                return true
            } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
                return true
            }
        }
        return false
    }
}


