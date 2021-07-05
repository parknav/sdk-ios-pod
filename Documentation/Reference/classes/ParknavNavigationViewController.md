**CLASS**

# `ParknavNavigationViewController`

**Contents**

- [Properties](#properties)
  - `delegate`
  - `preferredStatusBarStyle`
- [Methods](#methods)
  - `presentFrom(_:options:)`
  - `showFrom(_:options:)`
  - `deinit`
  - `prepare(for:sender:)`
  - `viewDidLoad()`
  - `viewWillAppear(_:)`
  - `viewWillTransition(to:with:)`

```swift
public class ParknavNavigationViewController: UIViewController
```

View controller incapsulating all the functionality for the navigation to the parking with the specified parameters

## Properties
### `delegate`

```swift
public var delegate: ParknavEventsListener?
```

Object which implement Parknav navigation events listener protocol

### `preferredStatusBarStyle`

```swift
public override var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods
### `presentFrom(_:options:)`

```swift
class public func presentFrom(_ viewController: UIViewController,
                              options: ParknavRouteOptions?) -> ParknavNavigationViewController?
```

Present `ParknavNavigationViewController` modally from the specified view controoler

- parameter viewController: View controller to be present from
- parameter options: ParknavRouteOptions for the navigation
- returns: created and presented `ParknavNavigationViewController`

#### Parameters

| Name | Description |
| ---- | ----------- |
| viewController | View controller to be present from |
| options | ParknavRouteOptions for the navigation |

### `showFrom(_:options:)`

```swift
class public func showFrom(_ viewController: UIViewController,
                           options: ParknavRouteOptions?) -> ParknavNavigationViewController?
```

Present `ParknavNavigationViewController` in primary context from the specified view controoler

- parameter viewController: View controller to be present from
- parameter options: ParknavRouteOptions for the navigation
- returns: created and presented `ParknavNavigationViewController`

#### Parameters

| Name | Description |
| ---- | ----------- |
| viewController | View controller to be present from |
| options | ParknavRouteOptions for the navigation |

### `deinit`

```swift
deinit
```

### `prepare(for:sender:)`

```swift
public override func prepare(for segue: UIStoryboardSegue, sender: Any?)
```

### `viewDidLoad()`

```swift
public override func viewDidLoad()
```

### `viewWillAppear(_:)`

```swift
public override func viewWillAppear(_ animated: Bool)
```

### `viewWillTransition(to:with:)`

```swift
public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
```
