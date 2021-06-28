//[sdk](../../../../index.md)/[com.parknav.sdk.android.navigation.network](../../index.md)/[ParknavGaragesClient](../index.md)/[ParknavGaragesService](index.md)/[getGarages](get-garages.md)



# getGarages  
[androidJvm]  
Content  
@GET(value = v2/garage/garages)  
  
abstract fun [getGarages](get-garages.md)(@Query(value = destination)destination: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = userId)userId: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = radius)radius: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = clientInfo)clientInfo: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = locale)locale: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = platform)platform: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = sdkVersion)sdkVersion: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = polyline)polyline: [String](https://developer.android.com/reference/kotlin/java/lang/String.html)): Call<FeatureCollection>  



