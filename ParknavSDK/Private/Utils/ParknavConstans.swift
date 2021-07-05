//
//  ParknavConstans.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

struct ParknavConstans {
    struct Location {
        static let defaultLocation = CLLocationCoordinate2DMake(53.5254399, 9.9099633)
        static let maxDetectLocationTime: Double = 300
        static let locationActualityTimeinterval: Double = 120
        static let loactionActualityAccuracy: Double = 100
        static let locationsHistoryLength = 20
        static let maxRequestsCount = 3
        static let minDistanceToCalculateAngle = 50
        static let minTimeBeforeRerouting: TimeInterval = 1
        static let minDistanceBeforeRerouting: Double = 40
        static let minRouteScoreForParking: Double = 40
        static let movementTolerance: Double = 10
    }

    struct Layers {
        static let updateTime: TimeInterval = 300
        static let radius: Int = 1000
        static let reloadMargin: Double = 250
        static let showRouteMessageInterval: TimeInterval = 6
        static let garageRadiusOnParkingRoute: Int = 250
        static let shapeAnnotationAlpha: CGFloat = 0.5
    }

    struct Titles {
        static let locationDisabled = LocalizedString.locationDisabled.value
        static let errorAlertTitle = LocalizedString.error.value
        static let warningAlertTitle = LocalizedString.warning.value
        static let alertOK = LocalizedString.ok.value
        static let alertCancel = LocalizedString.cancel.value
    }

    struct Errors {
        static let locationNotDetected = NSError(domain: API.projectName, code: 400,
                                                 userInfo: [NSLocalizedDescriptionKey: LocalizedString.locationNotDetected.value])
        static let unknownError = NSError(domain: API.projectName, code: 400,
                                          userInfo: [NSLocalizedDescriptionKey: LocalizedString.unknownError.value])
        static let internetError = NSError(domain: API.projectName, code: 400,
                                           userInfo: [NSLocalizedDescriptionKey: LocalizedString.networkError.value])
        static let emptyRoute = NSError(domain: API.projectName, code: 400,
                                        userInfo: [NSLocalizedDescriptionKey: LocalizedString.emptyRoute.value])
        static let selfError = NSError(domain: API.projectName, code: 400,
                                        userInfo: [NSLocalizedDescriptionKey: LocalizedString.selfError.value])
    }

    // swiftlint:disable nesting
    struct API {
        struct Endpoints {
            static let directions = "biz/valet"
            static let navigation = "nav/navigation"
            static let heatmap = "biz/heatmap"
            static let bestArea = "biz/bestArea"
            static let garages = "garage/garages"
            static let endNavigation = "nav/endNavigation"
        }

        static let projectName = "ParknavSDK"
        static let apiKeyName = "apikey" // "Ocp-Apim-Subscription-Key"
        static let clientInfoPart = "mobile;ios;"
        static let parknavBaseURL = "http://parknav.com"
        static let fixedPartOfURL = "parknav.com/v2"

        static let mapboxAccessToken =
            "pk.eyJ1IjoiZWthdGVyaW5hLXBhcmtuYXYiLCJhIjoiY2tvZGEzanJuMDBkaTJ2czB0YjBxNDAwNyJ9.3y7o_vvo6M8hTBNKO6vFgQ"
//        "pk.eyJ1Ijoia296eXIiLCJhIjoiMzlkOTcxYjQ5NjQyMDYxZDkyZGUyMTIxNTQ5NDU2ODAifQ.oQ0UdRKknbf28hdaQYJN3g"
        static let SDKVersion = 4
    }
    // swiftlint:enable nesting

    // swiftlint:disable type_name
    struct UI {
        static let bottomBannerViewHeight: CGFloat = 80
    }
    // swiftlint:enable type_name

    struct Coding {
        static var decoder: JSONDecoder { JSONDecoder() }
    }
}
