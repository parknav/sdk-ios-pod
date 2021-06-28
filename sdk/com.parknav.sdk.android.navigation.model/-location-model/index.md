//[sdk](../../../index.md)/[com.parknav.sdk.android.navigation.model](../index.md)/[LocationModel](index.md)



# LocationModel  
 [androidJvm] open class [LocationModel](index.md) : [ParknavModel](../-parknav-model/index.md), PermissionsListener, [LocationStore](../../com.parknav.sdk.android.navigation.location/-location-store/index.md), LocationEngineCallback<LocationEngineResult>    


## Constructors  
  
| | |
|---|---|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/LocationModel/#android.app.Application/PointingToDeclaration/"></a>[LocationModel](-location-model.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/LocationModel/#android.app.Application/PointingToDeclaration/"></a> [androidJvm] open fun [LocationModel](-location-model.md)(@[NonNull](https://developer.android.com/reference/kotlin/androidx/annotation/NonNull.html)()application: [Application](https://developer.android.com/reference/kotlin/android/app/Application.html))   <br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/calculateBearing/#android.location.Location/PointingToDeclaration/"></a>[calculateBearing](calculate-bearing.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/calculateBearing/#android.location.Location/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [calculateBearing](calculate-bearing.md)(location: [Location](https://developer.android.com/reference/kotlin/android/location/Location.html)): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="androidx.lifecycle/AndroidViewModel/getApplication/#/PointingToDeclaration/"></a>[getApplication](../-accurate-location-model/index.md#1696759283%2FFunctions%2F462465411)| <a name="androidx.lifecycle/AndroidViewModel/getApplication/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun <[T](../-accurate-location-model/index.md#1696759283%2FFunctions%2F462465411) : [Application](https://developer.android.com/reference/kotlin/android/app/Application.html)?> [getApplication](../-accurate-location-model/index.md#1696759283%2FFunctions%2F462465411)(): [T](https://developer.android.com/reference/kotlin/androidx/lifecycle/ViewModel.html#settagifabsent)  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/getLocationRequest/#/PointingToDeclaration/"></a>[getLocationRequest](get-location-request.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/getLocationRequest/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [getLocationRequest](get-location-request.md)(): LocationEngineRequest  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/getUserLocation/#/PointingToDeclaration/"></a>[getUserLocation](get-user-location.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/getUserLocation/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [getUserLocation](get-user-location.md)(): [MutableLiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/MutableLiveData.html)<[Location](https://developer.android.com/reference/kotlin/android/location/Location.html)>  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/inReadyState/#/PointingToDeclaration/"></a>[inReadyState](in-ready-state.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/inReadyState/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [inReadyState](in-ready-state.md)(): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)  <br><br><br>|
| <a name="com.mapbox.android.core.permissions/PermissionsListener/onExplanationNeeded/#java.util.List<java.lang.String>/PointingToDeclaration/"></a>[onExplanationNeeded](../-accurate-location-model/index.md#-1974505229%2FFunctions%2F462465411)| <a name="com.mapbox.android.core.permissions/PermissionsListener/onExplanationNeeded/#java.util.List<java.lang.String>/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [onExplanationNeeded](../-accurate-location-model/index.md#-1974505229%2FFunctions%2F462465411)(p: [List](https://developer.android.com/reference/kotlin/java/util/List.html)<[String](https://developer.android.com/reference/kotlin/java/lang/String.html)>)  <br>open fun [onExplanationNeeded](on-explanation-needed.md)(permissionsToExplain: [List](https://developer.android.com/reference/kotlin/java/util/List.html)<[String](https://developer.android.com/reference/kotlin/java/lang/String.html)>)  <br><br><br>|
| <a name="com.mapbox.android.core.location/LocationEngineCallback/onFailure/#java.lang.Exception/PointingToDeclaration/"></a>[onFailure](../-accurate-location-model/index.md#-909249954%2FFunctions%2F462465411)| <a name="com.mapbox.android.core.location/LocationEngineCallback/onFailure/#java.lang.Exception/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [onFailure](../-accurate-location-model/index.md#-909249954%2FFunctions%2F462465411)(p: [Exception](https://developer.android.com/reference/kotlin/java/lang/Exception.html))  <br>open fun [onFailure](on-failure.md)(@[NonNull](https://developer.android.com/reference/kotlin/androidx/annotation/NonNull.html)()exception: [Exception](https://developer.android.com/reference/kotlin/java/lang/Exception.html))  <br><br><br>|
| <a name="com.mapbox.android.core.permissions/PermissionsListener/onPermissionResult/#boolean/PointingToDeclaration/"></a>[onPermissionResult](../-accurate-location-model/index.md#672581864%2FFunctions%2F462465411)| <a name="com.mapbox.android.core.permissions/PermissionsListener/onPermissionResult/#boolean/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [onPermissionResult](../-accurate-location-model/index.md#672581864%2FFunctions%2F462465411)(p: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html))  <br>open fun [onPermissionResult](on-permission-result.md)(granted: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html))  <br><br><br>|
| <a name="com.mapbox.android.core.location/LocationEngineCallback/onSuccess/#T/PointingToDeclaration/"></a>[onSuccess](../-accurate-location-model/index.md#-2131236194%2FFunctions%2F462465411)| <a name="com.mapbox.android.core.location/LocationEngineCallback/onSuccess/#T/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [onSuccess](../-accurate-location-model/index.md#-2131236194%2FFunctions%2F462465411)(p: [T](https://developer.android.com/reference/kotlin/androidx/lifecycle/ViewModel.html#settagifabsent))  <br>open fun [onSuccess](on-success.md)(result: LocationEngineResult)  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/restoreState/#android.content.Intent/PointingToDeclaration/"></a>[restoreState](restore-state.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/restoreState/#android.content.Intent/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [restoreState](restore-state.md)(startIntent: [Intent](https://developer.android.com/reference/kotlin/android/content/Intent.html))  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/updateUserLocation/#android.location.Location/PointingToDeclaration/"></a>[updateUserLocation](update-user-location.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/updateUserLocation/#android.location.Location/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [updateUserLocation](update-user-location.md)(location: [Location](https://developer.android.com/reference/kotlin/android/location/Location.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.parknav.sdk.android.navigation.model/LocationModel/locationState/#/PointingToDeclaration/"></a>[locationState](location-state.md)| <a name="com.parknav.sdk.android.navigation.model/LocationModel/locationState/#/PointingToDeclaration/"></a> [androidJvm] protected val [locationState](location-state.md): [MutableLiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/MutableLiveData.html)<[VariableState](../-variable-state/index.md)>   <br>|


## Inheritors  
  
|  Name | 
|---|
| <a name="com.parknav.sdk.android.navigation.model/LocationModelForNavigation///PointingToDeclaration/"></a>[LocationModelForNavigation](../-location-model-for-navigation/index.md)|
| <a name="com.parknav.sdk.android.navigation.model/AccurateLocationModel///PointingToDeclaration/"></a>[AccurateLocationModel](../-accurate-location-model/index.md)|

