package com.example.hitek_test.network_config

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest

class NetworkConnectivityListener(private val context: Context) {

    private val connectivityManager: ConnectivityManager =
        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

    private var networkCallback: ConnectivityManager.NetworkCallback? = null

    fun startListening(listener: NetworkConnectivityListenerCallback) {
        val networkRequest = NetworkRequest.Builder()
            .addTransportType(NetworkCapabilities.TRANSPORT_CELLULAR)
            .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
            .build()

        networkCallback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                listener.onNetworkAvailable()
            }

            override fun onLost(network: Network) {
                listener.onNetworkLost()
            }
        }

        connectivityManager.registerNetworkCallback(networkRequest, networkCallback!!)
    }

    fun stopListening() {
        networkCallback?.let {
            connectivityManager.unregisterNetworkCallback(it)
            networkCallback = null
        }
    }

    interface NetworkConnectivityListenerCallback {
        fun onNetworkAvailable()
        fun onNetworkLost()
    }
}

