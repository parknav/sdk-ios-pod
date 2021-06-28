//[sdk](../../../../index.md)/[com.parknav.sdk.android.navigation.network](../../index.md)/[ParknavLayersClient](../index.md)/[ParknavLayersService](index.md)/[getBestArea](get-best-area.md)



# getBestArea  
[androidJvm]  
Content  
@GET(value = v2/biz/bestArea)  
  
abstract fun [getBestArea](get-best-area.md)(@Query(value = destination)destination: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = userId)userId: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = clientInfo)clientInfo: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = sdkVersion)sdkVersion: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = radius)radius: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = minSize)minSize: [Integer](https://developer.android.com/reference/kotlin/java/lang/Integer.html), @Query(value = maxSize)maxSize: [Integer](https://developer.android.com/reference/kotlin/java/lang/Integer.html), @Query(value = numAreas)numAreas: [Integer](https://developer.android.com/reference/kotlin/java/lang/Integer.html)): Call<FeatureCollection>  



