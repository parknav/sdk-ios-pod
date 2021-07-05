**PROTOCOL**

# `ParknavEventsListener`

```swift
public protocol ParknavEventsListener: AnyObject
```

Parknav navigation events listener protocol

ParknavSDK calls the methods of this protocol to notify about some navigation events inside of the navigation objects

## Methods
### `shouldReroute(from:)`

```swift
func shouldReroute(from location: CLLocation) -> Bool
```

Asks whether one of the Parknav navigation view controllers should be allowed to calculate a new route.

- parameter location: The user’s current location.
- returns: True to allow the Parknav navigation view controller to calculate a new route;
false to keep tracking the current route.

#### Parameters

| Name | Description |
| ---- | ----------- |
| location | The user’s current location. |

### `navigationExit(_:)`

```swift
func navigationExit(_ navigationObject: ParknavNavigationObject)
```

Called when the navigation was finished

- parameter navigationObject: The instance of `ParknavNavigationObject` with the result of nuvigation.

#### Parameters

| Name | Description |
| ---- | ----------- |
| navigationObject | The instance of `ParknavNavigationObject` with the result of nuvigation. |

### `didChangeRoute(_:)`

```swift
func didChangeRoute(_ route: Route)
```

### `didArriveToParking(_:)`

```swift
func didArriveToParking(_ waipoint: Waypoint) -> Bool
```

Called when one of the Parknav navigation view controllers arrived to the parking
and asks whether it should continue navigation or not.

- parameter waipoint:  The instance of `Waypoint` which contains the inforation about the user's current location
- returns: True to signal that the user has actually arrived at the parking and there is no need to continue navigation;
false in the opposite case

#### Parameters

| Name | Description |
| ---- | ----------- |
| waipoint | The instance of `Waypoint` which contains the inforation about the user’s current location |