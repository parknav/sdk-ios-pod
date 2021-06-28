//[sdk](../../../index.md)/[com.parknav.sdk.android.navigation.model](../index.md)/[LayersModel](index.md)



# LayersModel  
 [androidJvm] open class [LayersModel](index.md) : [ParknavModel](../-parknav-model/index.md)   


## Constructors  
  
| | |
|---|---|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/LayersModel/#android.app.Application/PointingToDeclaration/"></a>[LayersModel](-layers-model.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/LayersModel/#android.app.Application/PointingToDeclaration/"></a> [androidJvm] open fun [LayersModel](-layers-model.md)(@[NonNull](https://developer.android.com/reference/kotlin/androidx/annotation/NonNull.html)()application: [Application](https://developer.android.com/reference/kotlin/android/app/Application.html))   <br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/addLayersSource/#com.parknav.sdk.android.navigation.model.ParknavLayer/PointingToDeclaration/"></a>[addLayersSource](add-layers-source.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/addLayersSource/#com.parknav.sdk.android.navigation.model.ParknavLayer/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [addLayersSource](add-layers-source.md)(parknavLayer: [ParknavLayer](../-parknav-layer/index.md)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)  <br><br><br>|
| <a name="androidx.lifecycle/AndroidViewModel/getApplication/#/PointingToDeclaration/"></a>[getApplication](../-accurate-location-model/index.md#1696759283%2FFunctions%2F462465411)| <a name="androidx.lifecycle/AndroidViewModel/getApplication/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun <[T](../-accurate-location-model/index.md#1696759283%2FFunctions%2F462465411) : [Application](https://developer.android.com/reference/kotlin/android/app/Application.html)?> [getApplication](../-accurate-location-model/index.md#1696759283%2FFunctions%2F462465411)(): [T](https://developer.android.com/reference/kotlin/androidx/lifecycle/ViewModel.html#settagifabsent)  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/getDestination/#/PointingToDeclaration/"></a>[getDestination](get-destination.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/getDestination/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [getDestination](get-destination.md)(): [Location](https://developer.android.com/reference/kotlin/android/location/Location.html)  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/getParknavOptions/#/PointingToDeclaration/"></a>[getParknavOptions](get-parknav-options.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/getParknavOptions/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [getParknavOptions](get-parknav-options.md)(): [ParknavOptions](../../com.parknav.sdk.android.navigation.util/-parknav-options/index.md)  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/loadLayersData/#android.location.Location#boolean/PointingToDeclaration/"></a>[loadLayersData](load-layers-data.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/loadLayersData/#android.location.Location#boolean/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [loadLayersData](load-layers-data.md)(location: [Location](https://developer.android.com/reference/kotlin/android/location/Location.html), updateLayers: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html))  <br>open fun [loadLayersData](load-layers-data.md)(currentDestination: LatLng, updateLayers: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html))  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/restoreState/#android.content.Intent/PointingToDeclaration/"></a>[restoreState](restore-state.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/restoreState/#android.content.Intent/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [restoreState](restore-state.md)(startIntent: [Intent](https://developer.android.com/reference/kotlin/android/content/Intent.html))  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/setDestination/#android.location.Location/PointingToDeclaration/"></a>[setDestination](set-destination.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/setDestination/#android.location.Location/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [setDestination](set-destination.md)(destination: [Location](https://developer.android.com/reference/kotlin/android/location/Location.html))  <br>open fun [setDestination](set-destination.md)(destination: LatLng)  <br><br><br>|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/updateDestination/#com.mapbox.mapboxsdk.geometry.LatLng#int/PointingToDeclaration/"></a>[updateDestination](update-destination.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/updateDestination/#com.mapbox.mapboxsdk.geometry.LatLng#int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun [updateDestination](update-destination.md)(currentDestination: LatLng, distanceTolerance: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/lastMapZoom/#/PointingToDeclaration/"></a>[lastMapZoom](last-map-zoom.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/lastMapZoom/#/PointingToDeclaration/"></a> [androidJvm] private var [lastMapZoom](last-map-zoom.md): [MutableLiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/MutableLiveData.html)<[Double](https://developer.android.com/reference/kotlin/java/lang/Double.html)>   <br>|
| <a name="com.parknav.sdk.android.navigation.model/LayersModel/layersDataMerger/#/PointingToDeclaration/"></a>[layersDataMerger](layers-data-merger.md)| <a name="com.parknav.sdk.android.navigation.model/LayersModel/layersDataMerger/#/PointingToDeclaration/"></a> [androidJvm] private val [layersDataMerger](layers-data-merger.md): [MediatorLiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/MediatorLiveData.html)<[ParknavLayer](../-parknav-layer/index.md)>   <br>|

