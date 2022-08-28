package com.agaafar.airwallex

import android.app.Application
import com.airwallex.android.card.CardComponent
import com.airwallex.android.core.Airwallex
import com.airwallex.android.core.AirwallexConfiguration
import com.airwallex.android.core.Environment
import android.text.TextUtils
import com.airwallex.android.redirect.RedirectComponent
import com.airwallex.android.wechat.WeChatComponent
import com.airwallex.android.core.ActionComponentProvider
import com.airwallex.android.core.ActionComponent
import com.airwallex.android.core.AirwallexPlugins
import com.airwallex.android.core.AirwallexPaymentSession
import com.airwallex.android.AirwallexStarter
import com.airwallex.android.core.AirwallexPaymentStatus
import com.airwallex.android.core.AirwallexSession
import com.airwallex.android.core.model.*
import com.airwallex.android.core.model.Address
import org.json.JSONObject

class AirwallexApi{
    
    fun initialize(logging: Boolean, environment: String, componentProvider: List<String>): String{
        var environment = when(environment){
            "STAGING" -> Environment.STAGING
            "DEMO" -> Environment.DEMO
            "PRODUCTION" -> Environment.PRODUCTION
            else -> throw Exception("No environment")
        }
        var componentProviderList: List<ActionComponentProvider<out ActionComponent>> =  when(componentProvider){
            listOf("CARD") -> listOf(CardComponent.PROVIDER)
            listOf("REDIRECT") -> listOf(RedirectComponent.PROVIDER) 
            listOf("WECHAT") -> listOf(WeChatComponent.PROVIDER)
            listOf("CARD", "REDIRECT") -> listOf(CardComponent.PROVIDER, RedirectComponent.PROVIDER)
            listOf("CARD" , "WECHAT") -> listOf(CardComponent.PROVIDER, WeChatComponent.PROVIDER)
            listOf("REDIRECT", "WECHAT") -> listOf(RedirectComponent.PROVIDER, WeChatComponent.PROVIDER)
            listOf("CARD", "WECHAT", "REDIRECT") -> listOf(CardComponent.PROVIDER, WeChatComponent.PROVIDER, RedirectComponent.PROVIDER)
            else -> listOf(CardComponent.PROVIDER)
        }
        Airwallex.initialize(
            AirwallexConfiguration.Builder()
            .enableLogging(logging)
            .setEnvironment(environment)
            .setSupportComponentProviders(
                componentProviderList
            )
            .build(),
        )
        return "Success"
    }

    fun getEnvironment(): String {
     val baseUrl = AirwallexPlugins.environment.baseUrl().toString()
     return baseUrl
    }

}