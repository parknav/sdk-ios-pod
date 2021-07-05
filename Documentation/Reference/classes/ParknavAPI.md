**CLASS**

# `ParknavAPI`

**Contents**

- [Methods](#methods)
  - `getDirections(currentLocation:currentAngle:options:)`
  - `getLayer(_:serverInfo:)`

```swift
public class ParknavAPI
```

Service for the intercation with Parknav API

## Methods
### `getDirections(currentLocation:currentAngle:options:)`

```swift
public class func getDirections(currentLocation: CLLocationCoordinate2D,
                                currentAngle: Double = 0,
                                options: ParknavRouteOptions) -> Future<DirectionsResponse, NSError>
```

Request for the itinerary between the current location and the most optimal parking near the destination or current location

- parameter currentLocation: The user’s current location.
- parameter currentAngle: The angle of the navigation, `default` is 0
- parameter options: `ParknavRouteOptions object with parameters for the route creation
- returns: if success: `DirectionsResponse` object, if failure: error

#### Parameters

| Name | Description |
| ---- | ----------- |
| currentLocation | The user’s current location. |
| currentAngle | The angle of the navigation, `default` is 0 |
| options | `ParknavRouteOptions object with parameters for the route creation |

### `getLayer(_:serverInfo:)`

```swift
public class func getLayer(_ layer: ParknavLayer, serverInfo: ServerInfo?) ->
    Future<MGLShapeCollectionFeature, NSError>
```

Request for the parking probability layer

- parameter layer: Parknav layer managing object
- parameter serverInfo: Information about the used Parknav API, contains URL and API key
- returns: if success: `MGLShapeCollectionFeature` object — GeoJSON with the information
for displaying the layer on the map, if failure: error

#### Parameters

| Name | Description |
| ---- | ----------- |
| layer | Parknav layer managing object |
| serverInfo | Information about the used Parknav API, contains URL and API key |