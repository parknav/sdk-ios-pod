//[sdk](../../../../index.md)/[com.parknav.sdk.android.navigation.network](../../index.md)/[ParknavGaragesClient](../index.md)/[ParknavGaragesService](index.md)



# ParknavGaragesService  
 [androidJvm] interface [ParknavGaragesService](index.md)   


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="com.parknav.sdk.android.navigation.network/ParknavGaragesClient.ParknavGaragesService/getGarages/#java.lang.String#java.lang.String#int#java.lang.String#java.lang.String#java.lang.String#int#java.lang.String/PointingToDeclaration/"></a>[getGarages](get-garages.md)| <a name="com.parknav.sdk.android.navigation.network/ParknavGaragesClient.ParknavGaragesService/getGarages/#java.lang.String#java.lang.String#int#java.lang.String#java.lang.String#java.lang.String#int#java.lang.String/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>@GET(value = v2/garage/garages)  <br>  <br>abstract fun [getGarages](get-garages.md)(@Query(value = destination)destination: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = userId)userId: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = radius)radius: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = clientInfo)clientInfo: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = locale)locale: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = platform)platform: [String](https://developer.android.com/reference/kotlin/java/lang/String.html), @Query(value = sdkVersion)sdkVersion: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), @Query(value = polyline)polyline: [String](https://developer.android.com/reference/kotlin/java/lang/String.html)): Call<FeatureCollection>  <br><br><br>|

