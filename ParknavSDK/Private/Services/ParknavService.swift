//
//  ParknavService.swift
//  ParknavSDK
//

import Foundation
import Alamofire
import BrightFutures
import CoreLocation
import Mapbox
import MapboxDirections

class ParknavService {
    enum Router: URLRequestConvertible {
        case getDirections(Bool, CLLocationCoordinate2D, String, CLLocationCoordinate2D, String, ParknavRouteOptions.SpotType,
            ParknavRouteOptions.Proximity, Double, String, Bool, Bool, String?, Int, ParknavRouteOptions.Lang?,
            ParknavRouteOptions.OutputFormat, ParknavRouteOptions.RouteSource, ParknavRouteOptions.CurrentDirection?)
        case getGarages(
            String,
            CLLocationCoordinate2D,
            Int,
            String,
            String)
        case endNavigation(Bool, CLLocationCoordinate2D, String, String)

        var method: HTTPMethod {
            switch self {
            case .getDirections, .getGarages: return .get
            case .endNavigation: return .post
            }
        }

        var encoding: ParameterEncoding {
            switch self {
            case .getDirections, .getGarages:
                return URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .literal)
            case .endNavigation: return JSONEncoding()
            }
        }

        var path: String {
            switch self {
            case .getDirections(let forNavigationOnly, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _):
                return forNavigationOnly ?  ParknavConstans.API.Endpoints.navigation : ParknavConstans.API.Endpoints.directions
            case .getGarages: return ParknavConstans.API.Endpoints.garages
            case .endNavigation: return ParknavConstans.API.Endpoints.endNavigation
            }
        }

        var baseURL: String {
            switch self {
            case .getDirections(_, _, _, let currentLocation, _, _, _, _, _, _, _, _, _, _, _, _, _):
                return ParknavServiceHelper.instance.getServiceEndpointInfo(currentLocation).URL
            case .getGarages(_, let destination, _, _, _):
                return ParknavServiceHelper.instance.getServiceEndpointInfo(destination).URL
            case .endNavigation(_, let endLocation, _, _):
                return ParknavServiceHelper.instance.getServiceEndpointInfo(endLocation).URL
            }
        }

        var apiKey: String {
            switch self {
            case .getDirections(_, _, _, let currentLocation, _, _, _, _, _, _, _, _, _, _, _, _, _):
                return ParknavServiceHelper.instance.getServiceEndpointInfo(currentLocation).APIKey
            case .getGarages(_, let destination, _, _, _):
                return ParknavServiceHelper.instance.getServiceEndpointInfo(destination).APIKey
            case .endNavigation(_, let endLocation, _, _):
                return ParknavServiceHelper.instance.getServiceEndpointInfo(endLocation).APIKey
            }
        }

        func asURLRequest() throws -> URLRequest {
            let requestURL = URL(string: baseURL + path)!
            guard let urlRequest = try? URLRequest(url: requestURL, method: method,
                                                   headers: [ParknavConstans.API.apiKeyName: apiKey])
                    as URLRequestConvertible else { return URLRequest(url: requestURL) }
            let parameters: ([String: Any]) = {
                switch self {
                case let .getDirections(_, destination, userId, currentLocation, clientInfo, spotType, proximity, currentAngle,
                                        locale, navigateToDest, pathStartsAtCurrentLocation, requestId, maxPathLength, lang,
                                        outputFormat, dataSources, currentDirection):
                    var params: [String: Any] = [
                        "destination": "\(destination.latitude), \(destination.longitude)", "platform": "ios",
                        "userId": userId, "currentLocation": "\(currentLocation.latitude), \(currentLocation.longitude)",
                        "clientInfo": clientInfo, "spotType": spotType.rawValue,
                        "proximity": proximity.rawValue, "currentAngle": currentAngle,
                        "locale": locale, "navigateToDest": navigateToDest,
                        "pathStartsAtCurrentLocation": pathStartsAtCurrentLocation, "maxPathLength": maxPathLength,
                        "outputFormat": outputFormat.rawValue, "sdkVersion": ParknavConstans.API.SDKVersion,
                        "dataSources": dataSources.value ] // Bundle.version(Bundle.mainSDKBundle)
                    if let lang = lang { params["lang"] = lang.rawValue }
                    if let requestId = requestId { params["requestId"] = requestId }
                    if let currentDirection = currentDirection { params["currentDirection"] = currentDirection.rawValue }
                    return params
                case let .getGarages(userID, destination, radius, clientInfo, locale):
                    return ["userId": userID,
                            "destination": "\(destination.latitude), \(destination.longitude)",
                            "radius": radius,
                            "clientInfo": clientInfo,
                            "locale": locale]
                case let .endNavigation(parked, endLocation, userID, clientInfo):
                    return ["parked": parked,
                            "location": "\(endLocation.latitude), \(endLocation.longitude)",
                            "userId": userID,
                            "clientInfo": clientInfo,
                            "sdkVersion": ParknavConstans.API.SDKVersion]
                }
            }()
            return (try? encoding.encode(urlRequest, with: parameters)) ?? URLRequest(url: requestURL)
        }
    }

    // swiftlint:disable function_parameter_count
    class func getDirections(
        forNavigationOnly: Bool,
        destination: CLLocationCoordinate2D,
        userId: String,
        currentLocation: CLLocationCoordinate2D,
        clientInfo: String,
        spotType: ParknavRouteOptions.SpotType,
        proximity: ParknavRouteOptions.Proximity,
        currentAngle: Double,
        locale: String,
        navigateToDest: Bool,
        pathStartsAtCurrentLocation: Bool,
        outputFormat: ParknavRouteOptions.OutputFormat,
        maxPathLength: Int,
        lang: ParknavRouteOptions.Lang?,
        requestId: String? = nil,
        routeSource: ParknavRouteOptions.RouteSource = .prob,
        currentDirection: ParknavRouteOptions.CurrentDirection? = nil) -> Future<DirectionsResponse, NSError> {

        let promise = Promise<DirectionsResponse, NSError>()

        let utilityQueue = DispatchQueue.global(qos: .utility)
        _ = request(Router.getDirections(forNavigationOnly, destination, userId, currentLocation, clientInfo, spotType,
                                         proximity, currentAngle, locale, navigateToDest, pathStartsAtCurrentLocation,
                                         requestId, maxPathLength, lang, outputFormat, routeSource, currentDirection))
            .responseJSONObject(queue: utilityQueue) { (response: DataResponse<DirectionsResponse>) in
                switch response.result {
                case .success(let value):
                    // We don't have control of the Info.plist, so we embed the token in the route to avoid an assertion.
                    value.routes.forEach({ (route) in
                        route.accessToken = ParknavConstans.API.mapboxAccessToken
                    })
                    promise.success(value)
                case .failure(let error):
                    promise.failure(error as NSError)
                @unknown default: break
                }
            }
        return promise.future
    }
    // swiftlint:enable function_parameter_count

    class func getGarages(userId: String,
                          destination: CLLocationCoordinate2D,
                          radius: Int,
                          clientInfo: String,
                          locale: String) -> Future<MGLShapeCollectionFeature, NSError> {
        let promise = Promise<MGLShapeCollectionFeature, NSError>()
        let utilityQueue = DispatchQueue.global(qos: .utility)
        _ = request(Router.getGarages(userId, destination, radius, clientInfo, locale))
            .responseDataObject(queue: utilityQueue) { response in
                if let data = response.data,
                    let shape = try? MGLShape(data: data, encoding: String.Encoding.utf8.rawValue),
                    let shapeCollectionFeauture = shape as? MGLShapeCollectionFeature {
                    promise.success(shapeCollectionFeauture)
                } else if let error = response.error {
                    promise.failure(error as NSError)
                } else {
                    promise.failure(ParknavConstans.Errors.unknownError)
                }
        }
        return promise.future
    }

    class func endNavigation(isParked: Bool,
                             endLocation: CLLocationCoordinate2D,
                             userId: String,
                             clientInfo: String,
                             countOfTries: Int) -> Future<Bool, NSError> {
        let promise = Promise<Bool, NSError>()

        let utilityQueue = DispatchQueue.global(qos: .utility)
        _ = request(Router.endNavigation(isParked, endLocation, userId, clientInfo))
            .responseDictionary(queue: utilityQueue) { response in
                switch response.result {
                case .success(_):
                    promise.success(true)
                case .failure(let error):
                    if countOfTries < ParknavConstans.Location.maxRequestsCount {
                        endNavigation(isParked: isParked, endLocation: endLocation, userId: userId,
                                      clientInfo: clientInfo, countOfTries: countOfTries + 1)
                            .onSuccess { _ in
                                promise.success(true)
                            }.onFailure { error in
                                promise.failure(error)
                        }
                    } else {
                        promise.failure(error as NSError)
                    }
                @unknown default: break
                }
        }
        return promise.future
    }
}
