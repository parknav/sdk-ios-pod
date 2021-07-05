**ENUM**

# `ParknavRouteOptions.CurrentDirection`

**Contents**

- [Cases](#cases)
  - `north`
  - `west`
  - `south`
  - `east`
  - `northWest`
  - `southEast`
  - `southWest`
  - `northEast`

```swift
public enum CurrentDirection: String
```

Gives the current heading of the car at current location. Doesn’t have to be accurate, but setting it correctly
helps avoid U-turns at the very first street.

## Cases
### `north`

```swift
case north = "N"
```

### `west`

```swift
case west = "W"
```

### `south`

```swift
case south = "S"
```

### `east`

```swift
case east = "E"
```

### `northWest`

```swift
case northWest = "NW"
```

### `southEast`

```swift
case southEast = "SE"
```

### `southWest`

```swift
case southWest = "SW"
```

### `northEast`

```swift
case northEast = "NE"
```
