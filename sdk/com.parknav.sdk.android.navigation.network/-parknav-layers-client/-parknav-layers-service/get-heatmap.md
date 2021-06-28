//[sdk](../../../../index.md)/[com.parknav.sdk.android.navigation.network](../../index.md)/[ParknavLayersClient](../index.md)/[ParknavLayersService](index.md)/[getHeatmap](get-heatmap.md)



# getHeatmap  
[androidJvm]  
Content  
@GET(value = v2/biz/heatmap)  
  
abstract fun [getHeatmap](get-heatmap.md)(@Query(value = destination)destination: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = userId)userId: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = clientInfo)clientInfo: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = sdkVersion)sdkVersion: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = outputFormat)outputFormat: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = spotType)spotType: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = radius)radius: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = minProb)minProb: [Double](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-double/index.html), @Query(value = maxProb)maxProb: [Double](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-double/index.html)): Call<FeatureCollection>  



