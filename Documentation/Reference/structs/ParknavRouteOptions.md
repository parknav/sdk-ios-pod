**STRUCT**

# `ParknavRouteOptions`

**Contents**

- [Properties](#properties)
  - `destination`
  - `spotType`
  - `proximity`
  - `lang`
  - `localeID`
  - `navigateToDestination`
  - `maxPathLength`
  - `outputFormat`
  - `previousRequestId`
  - `dayStyle`
  - `nightStyle`
  - `serverInfo`
  - `isSimulationEnabled`
  - `destinationReachedThreshold`
  - `showRouteType`
  - `allowDestinationSelection`
  - `isNavigationOnly`
  - `garageSupport`
  - `garagesOnParkingRoute`
  - `garageRadius`
  - `routeSource`
  - `isFullscreen`
- [Methods](#methods)
  - `init()`

```swift
public struct ParknavRouteOptions
```

`ParknavRouteOptions` structure used to configure the parameters of the requested route

## Properties
### `destination`

```swift
public var destination: CLLocationCoordinate2D?
```

Destination location

### `spotType`

```swift
public var spotType: SpotType = .all
```

Type of the parking spot

### `proximity`

```swift
public var proximity: Proximity = .close
```

Determines whether to focus on parking close to the destination or in a wider area

### `lang`

```swift
public var lang: Lang?
```

Code for the language of the instructions

### `localeID`

```swift
public var localeID: String = Locale.current.identifier
```

Current locale identifier

### `navigateToDestination`

```swift
public var navigateToDestination: Bool = true
```

Should the returned path include a navigation from current position to the destination

### `maxPathLength`

```swift
public var maxPathLength: Int = 1000
```

Caps route at this number of street segments

### `outputFormat`

```swift
public var outputFormat: OutputFormat = .mapbox
```

Outputs results for the route

### `previousRequestId`

```swift
public var previousRequestId: String?
```

Previous request ID

### `dayStyle`

```swift
public var dayStyle: MapStyle?
```

Day style for the map

### `nightStyle`

```swift
public var nightStyle: MapStyle?
```

Night style for the map

### `serverInfo`

```swift
public var serverInfo: ServerInfo?
```

Information about the used Parknav API

### `isSimulationEnabled`

```swift
public var isSimulationEnabled: Bool = false
```

Is simulation mode enabled

### `destinationReachedThreshold`

```swift
public var destinationReachedThreshold: Double = 100
```

Destination reached threshold (in meters)

### `showRouteType`

```swift
public var showRouteType: Bool = true
```

Whether or not to show the route info

### `allowDestinationSelection`

```swift
public var allowDestinationSelection: Bool = false
```

Whether the destination selection on the map is available

### `isNavigationOnly`

```swift
public var isNavigationOnly: Bool = false
```

### `garageSupport`

```swift
public var garageSupport: GarageSupport = .noGarages
```

Garage support type

### `garagesOnParkingRoute`

```swift
public var garagesOnParkingRoute: Bool = false
```

Whether to show garages on the route

### `garageRadius`

```swift
public var garageRadius: Int = ParknavConstans.Layers.radius
```

Garages display radius

### `routeSource`

```swift
public var routeSource: RouteSource = .prob
```

Data sources for the creation paking route

### `isFullscreen`

```swift
public var isFullscreen = true
```

Should display navigtion view controller at the full screen

## Methods
### `init()`

```swift
public init()
```
