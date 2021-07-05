//
//  ParknavRouteOptions.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

/**
 Information about the used Parknav API, contains URL and API key
 */
public typealias ServerInfo = (_ currentLocation: CLLocationCoordinate2D) -> ServiceEndpointInfo

/**
 `ParknavRouteOptions` structure used to configure the parameters of the requested route
 */
public struct ParknavRouteOptions {
    /**
     Type of the parking spot
     */
    public enum SpotType: String {
        case free
        case permit
        case paid
        case all
    }

    /**
     Determines whether to focus on parking close to the destination or in a wider area
     */
    public enum Proximity: String {
        case close
        case quick
    }
    /**
     Gives the current heading of the car at current location. Doesn’t have to be accurate, but setting it correctly
     helps avoid U-turns at the very first street.
     */
    public enum CurrentDirection: String {
        case north = "N"
        case west = "W"
        case south = "S"
        case east = "E"
        case northWest = "NW"
        case southEast = "SE"
        case southWest = "SW"
        case northEast = "NE"
    }

    /**
     Outputs results for the route and for Parknav layers
     */
    public enum OutputFormat: String {
        /**
         For the route: OSRM v5 format compatible with Mapbox Navigation SDK
         */
        case mapbox
        /**
         For the Heatmap layer: Parknav format
         */
        case legacy
        /**
         For the Heatmap layer: polylines
         */
        case normal
        /**
         For the Heatmap layer: geojson
         */
        case geojson
        /**
         For the route: series of waypoints
         */
        case parknav
    }

    /**
     Code for the language of the instructions. Default is English (en). Currently only English and German are supported.
     */
    // swiftlint:disable identifier_name
    public enum Lang: String {
        case en
        case de
    }
    // swiftlint:enable identifier_name

    /**
     GarageType
     */
    public enum GarageType: String {
        case garage
        case parkRide = "park-ride"
        case parkFly = "park-fly"
        case underground
    }

    /**
     Garage paymetn method
     */
    public enum PaymentMethod: String {
        case coin
        case bill
        case creditCard = "credit-card"
    }

    /**
     Payment control
     */
    public enum PaymentControl: String {
        case gate
        case attendant
        case videoMonitoring = "video-monitoring"
    }

    /**
     Garage support type
     */
    public enum GarageSupport: Int {
        case noGarages = 0
        case garagesFromStart
        case garagesWhenNoParking

        var stringValue: String {
            switch self {
            case .noGarages: return "noGarages"
            case .garagesFromStart: return "garagesFromStart"
            case .garagesWhenNoParking: return "garagesWhenNoParking"
            }
        }
    }

    /**
     Structure with information about the map style
     */
    public struct MapStyle {
        /**
         Mapbox map style URLx
         */
        var URL: String?
        /**
         Colors Scheme for the style
         */
        var colorsScheme: StyleColorsScheme?

        public init(URL: String?, colorsScheme: StyleColorsScheme?) {
            self.URL = URL
            self.colorsScheme = colorsScheme
        }
    }

    /**
     Data sources for the creation paking route
     */
    public enum RouteSource: Int {
        case prob = 0
        case garage
        case probgarage

        var value: String {
            switch self {
            case .prob: return "prob"
            case .garage: return "garage"
            case .probgarage: return"prob,garage"
            }
        }
    }

    // MARK: - Static properties
    /**
     Singleton objct for `ParknavRouteOptions`
     */
    public static var instance = ParknavRouteOptions()

    // MARK: - Public properties

    /**
     Destination location
     */
    public var destination: CLLocationCoordinate2D?
    /**
     Type of the parking spot
     */
    public var spotType: SpotType = .all
    /**
     Determines whether to focus on parking close to the destination or in a wider area
     */
    public var proximity: Proximity = .close
    /**
     Code for the language of the instructions
     */
    public var lang: Lang?
    /**
     Current locale identifier
     */
    public var localeID: String = Locale.current.identifier
    /**
     Should the returned path include a navigation from current position to the destination
     */
    public var navigateToDestination: Bool = true
//    public var pathStartsAtCurrentLocation: Bool = false
    /**
     Caps route at this number of street segments
     */
    public var maxPathLength: Int = 1000
    /**
     Outputs results for the route
     */
    public var outputFormat: OutputFormat = .mapbox
    /**
     Previous request ID
     */
    public var previousRequestId: String?
    /**
     Day style for the map
     */
    public var dayStyle: MapStyle?
    /**
     Night style for the map
     */
    public var nightStyle: MapStyle?
    /**
     Information about the used Parknav API
     */
    public var serverInfo: ServerInfo?
    /**
     Is simulation mode enabled
     */
    public var isSimulationEnabled: Bool = false
    /**
     Destination reached threshold (in meters)
     */
    public var destinationReachedThreshold: Double = 100
    /**
     Whether or not to show the route info
     */
    public var showRouteType: Bool = true
    /**
     Whether the destination selection on the map is available
     */
    public var allowDestinationSelection: Bool = false

    public var isNavigationOnly: Bool = false
    /**
     Garage support type
     */
    public var garageSupport: GarageSupport = .noGarages
    /**
     Whether to show garages on the route
     */
    public var garagesOnParkingRoute: Bool = false
    /**
     Garages display radius
     */
    public var garageRadius: Int = ParknavConstans.Layers.radius
    /**
     Data sources for the creation paking route
     */
    public var routeSource: RouteSource = .prob
    /**
     Should display navigtion view controller at the full screen
     */
    public var isFullscreen = true

    public init() {}
}
