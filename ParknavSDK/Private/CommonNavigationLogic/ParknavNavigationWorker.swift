//
//  ParknavNavigationWorker.swift
//  ParknavSDK
//

import UIKit
import CoreLocation
import BrightFutures

class ParknavNavigationWorker {
    // MARK: - Public properties

    var userId: String {
        _ = UserDefaultsService.service.loadFromUserDefaults()
        if let userID = UserDefaultsService.service.userId {
            return userID
        }
        let userID = UUID().uuidString
        UserDefaultsService.service.userId = userID
        _ = UserDefaultsService.service.saveToUserDefaults()
        return userID
    }

    var clientInfo: String { ParknavConstans.API.clientInfoPart + Bundle.versionString }

    // MARK: - Private properties

    private var countOfTries = 0

    // MARK: - Public functions

    func getRoute(_ currentLocation: CLLocationCoordinate2D, currentAngle: Double,
                  options: ParknavRouteOptions) -> Future<DirectionsResponse, NSError> {
            let promise = Promise<DirectionsResponse, NSError>()

        DispatchQueue.global().async { [weak self] in
            guard let self = self else { promise.failure(ParknavConstans.Errors.unknownError); return }
            print("count of tries: \(self.countOfTries)")
            self.countOfTries += 1

            let destination = options.destination ?? currentLocation
            ParknavServiceHelper.instance.serverInfo = options.serverInfo
            ParknavService.getDirections(
                forNavigationOnly: options.isNavigationOnly,
                destination: destination,
                userId: self.userId,
                currentLocation: currentLocation,
                clientInfo: self.clientInfo,
                spotType: options.spotType,
                proximity: options.proximity,
                currentAngle: currentAngle,
                locale: options.localeID,
                navigateToDest: options.navigateToDestination,
                pathStartsAtCurrentLocation: true,
                outputFormat: options.outputFormat,
                maxPathLength: options.maxPathLength,
                lang: options.lang,
                requestId: options.previousRequestId,
                routeSource: options.routeSource)
                .onSuccess { response in
                    if response.routes.isEmpty {
                        promise.failure(ParknavConstans.Errors.emptyRoute)
                    } else {
                        promise.success(response)
                    }
                }.onFailure { error in
                    if self.countOfTries < ParknavConstans.Location.maxRequestsCount {
                        self.getRoute(currentLocation, currentAngle: currentAngle, options: options)
                            .onSuccess {response in
                                promise.success(response)
                            }.onFailure { error in
                                promise.failure(error)
                            }
                    } else {
                        promise.failure(error)
                    }
                }
        }
        return promise.future
    }

    func sendEndNavigation(isParked: Bool, endLocation: CLLocationCoordinate2D?) {
        let endLocation = endLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        _ = ParknavService.endNavigation(isParked: isParked, endLocation: endLocation,
                                         userId: userId, clientInfo: clientInfo, countOfTries: 0)
    }
}
