//[sdk](../../../../index.md)/[com.parknav.sdk.android.navigation.network](../../index.md)/[ParknavDirectionClient](../index.md)/[ParkingInstructionsService](index.md)/[getNavigationRoute](get-navigation-route.md)



# getNavigationRoute  
[androidJvm]  
Content  
@GET(value = v2/nav/navigation)  
  
abstract fun [getNavigationRoute](get-navigation-route.md)(@Query(value = destination)destination: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = userId)userId: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = currentLocation)currentLocation: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = currentAngle)currentAngle: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = clientInfo)clientInfo: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = locale)locale: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = lang)lang: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = pathStartsAtCurrentLocation)pathStartsAtCurrentLocation: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), @Query(value = platform)platform: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = outputFormat)outputFormat: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = sdkVersion)sdkVersion: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = navigationType)navigationType: [String](https://developer.android.com/reference/kotlin/java/lang/String.html)): Call<DirectionsResponse>  



