**CLASS**

# `ParkingChanceViewController`

**Contents**

- [Methods](#methods)
  - `presentFrom(_:layerRules:options:)`
  - `deinit`
  - `prepare(for:sender:)`
  - `viewDidLoad()`
  - `viewWillAppear(_:)`
  - `viewDidAppear(_:)`
  - `viewWillDisappear(_:)`

```swift
public class ParkingChanceViewController: UIViewController
```

View controller incapsulating all the functionality for displaying the parking probability layers and l
 aunching navigation to the parking with the specified parameters

## Methods
### `presentFrom(_:layerRules:options:)`

```swift
class public func presentFrom(_ viewController: UIViewController,
                              layerRules: LayerRules?,
                              options: ParknavRouteOptions?) -> ParkingChanceViewController?
```

Present ParkingChance view controller from another one

- Parameter viewController: view controller from which will be presented ParkingChance
- Parameter layerRules: object with the information about layers to be displayed
- Parameter options: ParknavRouteOptions to use for the ParkingChance functionality
- Returns: ParkingChanceViewController object which was presented

#### Parameters

| Name | Description |
| ---- | ----------- |
| viewController | view controller from which will be presented ParkingChance |
| layerRules | object with the information about layers to be displayed |
| options | ParknavRouteOptions to use for the ParkingChance functionality |

### `deinit`

```swift
deinit
```

### `prepare(for:sender:)`

```swift
override public func prepare(for segue: UIStoryboardSegue, sender: Any?)
```

### `viewDidLoad()`

```swift
override public func viewDidLoad()
```

### `viewWillAppear(_:)`

```swift
public override func viewWillAppear(_ animated: Bool)
```

### `viewDidAppear(_:)`

```swift
public override func viewDidAppear(_ animated: Bool)
```

### `viewWillDisappear(_:)`

```swift
public override func viewWillDisappear(_ animated: Bool)
```
