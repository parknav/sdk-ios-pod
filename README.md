# ParknavSDK Documentation

## Installation

To install the SDK with CocoaPods add to your podfile the string:
```swift
pod 'ParknavSDK', :git => 'https://github.com/parknav/sdk-ios-pod.git'
```

## How to use

Before the launching any of Parknav SDK screens some of mondatory parameters should be configured. The Parknav API info should be provided through the instance of `ServiceEndpointInfo` class. It can be done this way:

```swift
ParknavRouteOptions.instance.serverInfo = { _ in
            ServiceEndpointInfo(URL: <URL of Parknav API>,
                                APIKey: <Parknav API key>)
}
```

To launch one of the Parknav SDK screens you can use the code from the following examples

### ParkingChanceViewController

```swift
var layerRules = LayerRules.instance
var options = ParknavRouteOptions.instance
ParkingChanceViewController.presentFrom(self, layerRules: layerRules, 
													options: options)
```

`layerRules` and `options` can be configured with available parameters before launching the screen, otherwise the parameters of default instances will be used

### ParknavNavigationViewController

```swift
let parknavNavigationVC = ParknavNavigationPreviewViewController
							.presentFrom(self, options: ParknavRouteOptions.instance)
parknavNavigationVC?.delegate = self
```

`delegate` property is used to set up the listener for navigation events

### ParknavNavigationPreviewViewController

```swift
let parknavNavigationVC = ParknavNavigationPreviewViewController
							.presentFrom(self, options: ParknavRouteOptions.instance)
parknavNavigationVC?.delegate = self
```

`delegate` property is used to set up the listener for navigation events



## Protocols

-   [ParknavEventsListener](Documentation/Reference/protocols/ParknavEventsListener.md)

## Structs

-   [DirectionsResponse](Documentation/Reference/structs/DirectionsResponse.md)
-   [LayerRules](Documentation/Reference/structs/LayerRules.md)
-   [ParknavNavigationObject](Documentation/Reference/structs/ParknavNavigationObject.md)
-   [ParknavRouteOptions](Documentation/Reference/structs/ParknavRouteOptions.md)
-   [ParknavRouteOptions.MapStyle](Documentation/Reference/structs/ParknavRouteOptions.MapStyle.md)
-   [ServiceEndpointInfo](Documentation/Reference/structs/ServiceEndpointInfo.md)

## Classes

-   [BestAreaLayer](Documentation/Reference/classes/BestAreaLayer.md)
-   [HeatmapLayer](Documentation/Reference/classes/HeatmapLayer.md)
-   [ParkingChanceViewController](Documentation/Reference/classes/ParkingChanceViewController.md)
-   [ParknavAPI](Documentation/Reference/classes/ParknavAPI.md)
-   [ParknavLayer](Documentation/Reference/classes/ParknavLayer.md)
-   [ParknavNavigationPreviewViewController](Documentation/Reference/classes/ParknavNavigationPreviewViewController.md)
-   [ParknavNavigationViewController](Documentation/Reference/classes/ParknavNavigationViewController.md)

## Enums

-   [LayerType](Documentation/Reference/enums/LayerType.md)
-   [NavigationExitType](Documentation/Reference/enums/NavigationExitType.md)
-   [ParknavRouteOptions.CurrentDirection](Documentation/Reference/enums/ParknavRouteOptions.CurrentDirection.md)
-   [ParknavRouteOptions.GarageSupport](Documentation/Reference/enums/ParknavRouteOptions.GarageSupport.md)
-   [ParknavRouteOptions.GarageType](Documentation/Reference/enums/ParknavRouteOptions.GarageType.md)
-   [ParknavRouteOptions.Lang](Documentation/Reference/enums/ParknavRouteOptions.Lang.md)
-   [ParknavRouteOptions.OutputFormat](Documentation/Reference/enums/ParknavRouteOptions.OutputFormat.md)
-   [ParknavRouteOptions.PaymentControl](Documentation/Reference/enums/ParknavRouteOptions.PaymentControl.md)
-   [ParknavRouteOptions.PaymentMethod](Documentation/Reference/enums/ParknavRouteOptions.PaymentMethod.md)
-   [ParknavRouteOptions.Proximity](Documentation/Reference/enums/ParknavRouteOptions.Proximity.md)
-   [ParknavRouteOptions.RouteSource](Documentation/Reference/enums/ParknavRouteOptions.RouteSource.md)
-   [ParknavRouteOptions.SpotType](Documentation/Reference/enums/ParknavRouteOptions.SpotType.md)
-   [StyleColorsScheme](Documentation/Reference/enums/StyleColorsScheme.md)

## Typealiases

-   [ServerInfo](Documentation/Reference/typealiases/ServerInfo.md)