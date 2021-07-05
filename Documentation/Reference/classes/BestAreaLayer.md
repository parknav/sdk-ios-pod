**CLASS**

# `BestAreaLayer`

**Contents**

- [Methods](#methods)
  - `init(destination:currentLocation:)`
  - `displayOnMap(_:shapeCollection:)`

```swift
public class BestAreaLayer: ParknavLayer
```

Class for the Parknav Best Area Layer managing object

Best Area Layer presens the polygon area with the maximal parking probability on the map.

## Methods
### `init(destination:currentLocation:)`

```swift
public required init(destination: CLLocationCoordinate2D, currentLocation: CLLocationCoordinate2D?)
```

`BestAreaLayeru` object initializer

- parameter destination: Destination location
- parameter currentLocation: Current user's location

#### Parameters

| Name | Description |
| ---- | ----------- |
| destination | Destination location |
| currentLocation | Current user’s location |

### `displayOnMap(_:shapeCollection:)`

```swift
public override func displayOnMap(_ mapView: MGLMapView, shapeCollection: MGLShapeCollectionFeature)
```

Display the layer on the map

- Parameter mapView: mapView to display the layer on
- Parameter shapeCollection: object of type MGLShapeCollectionFeature with all the geometric layer info

#### Parameters

| Name | Description |
| ---- | ----------- |
| mapView | mapView to display the layer on |
| shapeCollection | object of type MGLShapeCollectionFeature with all the geometric layer info |