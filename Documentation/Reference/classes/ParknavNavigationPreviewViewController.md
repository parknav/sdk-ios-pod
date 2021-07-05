**CLASS**

# `ParknavNavigationPreviewViewController`

**Contents**

- [Properties](#properties)
  - `preferredStatusBarStyle`
- [Methods](#methods)
  - `presentFrom(_:options:)`
  - `showFrom(_:options:)`

```swift
public class ParknavNavigationPreviewViewController: ParknavNavigationViewController
```

View controller incapsulating all the functionality for the navigation to the parking with the specified parameters
 including the route preview on the map

## Properties
### `preferredStatusBarStyle`

```swift
open override var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods
### `presentFrom(_:options:)`

```swift
override class public func presentFrom(_ viewController: UIViewController,
                                       options: ParknavRouteOptions?) -> ParknavNavigationPreviewViewController?
```

Present `ParknavNavigationPreviewViewController` modally from the specified view controoler

- parameter viewController: View controller to be present from
- parameter options: ParknavRouteOptions for the navigation
- returns: created and presented `ParknavNavigationPreviewViewController`

#### Parameters

| Name | Description |
| ---- | ----------- |
| viewController | View controller to be present from |
| options | ParknavRouteOptions for the navigation |

### `showFrom(_:options:)`

```swift
override class public func showFrom(_ viewController: UIViewController,
                                    options: ParknavRouteOptions?) -> ParknavNavigationPreviewViewController?
```

Present `ParknavNavigationPreviewViewController` in primary context from the specified view controoler

- parameter viewController: View controller to be present from
- parameter options: ParknavRouteOptions for the navigation
- returns: created and presented `ParknavNavigationPreviewViewController`

#### Parameters

| Name | Description |
| ---- | ----------- |
| viewController | View controller to be present from |
| options | ParknavRouteOptions for the navigation |