**ENUM**

# `ParknavRouteOptions.OutputFormat`

**Contents**

- [Cases](#cases)
  - `mapbox`
  - `legacy`
  - `normal`
  - `geojson`
  - `parknav`

```swift
public enum OutputFormat: String
```

Outputs results for the route and for Parknav layers

## Cases
### `mapbox`

```swift
case mapbox
```

For the route: OSRM v5 format compatible with Mapbox Navigation SDK

### `legacy`

```swift
case legacy
```

For the Heatmap layer: Parknav format

### `normal`

```swift
case normal
```

For the Heatmap layer: polylines

### `geojson`

```swift
case geojson
```

For the Heatmap layer: geojson

### `parknav`

```swift
case parknav
```

For the route: series of waypoints
