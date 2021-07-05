**CLASS**

# `ParknavMBNavigationViewController`

**Contents**

- [Methods](#methods)
  - `init(coder:)`
  - `init(for:directions:styles:locationManager:eventsListener:locationHistoryService:parknavRouteOptions:)`
  - `prepare(for:sender:)`
  - `viewDidLoad()`
  - `viewDidAppear(_:)`
  - `viewWillDisappear(_:)`
  - `viewDidLayoutSubviews()`

```swift
public class ParknavMBNavigationViewController: NavigationViewController
```

## Methods
### `init(coder:)`

```swift
required public init?(coder aDecoder: NSCoder)
```

### `init(for:directions:styles:locationManager:eventsListener:locationHistoryService:parknavRouteOptions:)`

```swift
public init(for route: Route, directions: Directions, styles: [Style]?, locationManager: NavigationLocationManager?, eventsListener: ParknavEventsListener?, locationHistoryService: LocationHistoryService, parknavRouteOptions: ParknavRouteOptions)
```

### `prepare(for:sender:)`

```swift
override public func prepare(for segue: UIStoryboardSegue, sender: Any?)
```

### `viewDidLoad()`

```swift
override public func viewDidLoad()
```

### `viewDidAppear(_:)`

```swift
public override func viewDidAppear(_ animated: Bool)
```

### `viewWillDisappear(_:)`

```swift
public override func viewWillDisappear(_ animated: Bool)
```

### `viewDidLayoutSubviews()`

```swift
public override func viewDidLayoutSubviews()
```
