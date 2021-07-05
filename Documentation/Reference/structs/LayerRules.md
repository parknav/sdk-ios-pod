**STRUCT**

# `LayerRules`

**Contents**

- [Properties](#properties)
  - `enabledLayers`
  - `updateTime`
  - `destination`
  - `userLocation`

```swift
public struct LayerRules
```

`LayerRules` structure used to manage the Parknav layers which should be displayed

## Properties
### `enabledLayers`

```swift
public var enabledLayers = [LayerType.heatmap, LayerType.bestArea]
```

Array of enabled layers' types

### `updateTime`

```swift
public var updateTime: TimeInterval = ParknavConstans.Layers.updateTime
```

The size of time interval between the layers update (in seconds)

### `destination`

```swift
public var destination: CLLocationCoordinate2D?
```

Destination to create the layer around

### `userLocation`

```swift
public var userLocation: CLLocation?
```

User location to create the layer
