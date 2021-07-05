**CLASS**

# `HeatmapLayer`

**Contents**

- [Methods](#methods)
  - `init(destination:currentLocation:)`
  - `displayOnMap(_:shapeCollection:)`

```swift
public class HeatmapLayer: ParknavLayer
```

Class for the Parknav Heatmap Layer managing object

Heatmap Layer presens parking availability information on the map
by coloring each street segment with different colors depending on difficulty.

## Methods
### `init(destination:currentLocation:)`

```swift
public required init(destination: CLLocationCoordinate2D, currentLocation: CLLocationCoordinate2D?)
```

`HeatmapLayer` object initializer

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