//[sdk](../../../../index.md)/[com.parknav.sdk.android.navigation.network](../../index.md)/[ParknavDirectionClient](../index.md)/[ParkingInstructionsService](index.md)/[getParkingInstructions](get-parking-instructions.md)



# getParkingInstructions  
[androidJvm]  
Content  
@GET(value = v2/biz/valet)  
  
abstract fun [getParkingInstructions](get-parking-instructions.md)(@Query(value = destination)destination: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = userId)userId: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = currentLocation)currentLocation: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = currentAngle)currentAngle: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = clientInfo)clientInfo: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = locale)locale: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = lang)lang: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = navigateToDest)navigateToDest: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), @Query(value = pathStartsAtCurrentLocation)pathStartsAtCurrentLocation: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), @Query(value = platform)platform: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = outputFormat)outputFormat: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = sdkVersion)sdkVersion: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = dataSources)routeSource: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = addWalkingTime)addWalkingTime: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), @Query(value = combinedTimesOnFirstLeg)combinedTimesOnFirstLeg: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)): Call<DirectionsResponse>  



