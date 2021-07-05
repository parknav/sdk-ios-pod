//
//  ParknavLayersService.swift
//  ParknavSDK

import Foundation
import Mapbox
import MapboxDirections
import Alamofire
import BrightFutures

class ParknavLayersService {

    class func getLayer(_ layer: ParknavLayer, countOfTries: Int) -> Future<MGLShapeCollectionFeature, NSError> {
        let promise = Promise<MGLShapeCollectionFeature, NSError>()

        let requestURL = URL(string: layer.baseURL + layer.path)!
        let urlRequest = (try? URLRequest(url: requestURL, method: .get,
                                          headers: [ParknavConstans.API.apiKeyName: layer.apiKey])
                as URLRequestConvertible) ?? URLRequest(url: requestURL)
        let encoding = URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .literal)
        let getRequest = try? encoding.encode(urlRequest, with: layer.parameters) as URLRequestConvertible
        let utilityQueue = DispatchQueue.global(qos: .background)
        _ =
            request(getRequest ?? URLRequest(url: requestURL))
            .responseDataObject(queue: utilityQueue) { response in
                if let data = response.data,
                    let shape = try? MGLShape(data: data, encoding: String.Encoding.utf8.rawValue),
                    let shapeCollectionFeauture = shape as? MGLShapeCollectionFeature {
                    promise.success(shapeCollectionFeauture)
                } else if countOfTries < ParknavConstans.Location.maxRequestsCount {
                    getLayer(layer, countOfTries: countOfTries + 1)
                        .onSuccess { shapeCollectionFeauture in
                            promise.success(shapeCollectionFeauture)
                        }.onFailure { error in
                            promise.failure(error)
                        }
                } else if let error = response.error {
                    promise.failure(error as NSError)
                } else {
                    promise.failure(ParknavConstans.Errors.unknownError)
                }
            }
        return promise.future
    }

    class func showLayers(map: MGLMapView, layerRules: LayerRules, configuration: ((ParknavLayer) -> (ParknavLayer))? = nil) {
        DispatchQueue.main.async {
            if let oldAnnotations = map.annotations {
                map.removeAnnotations(oldAnnotations)
            }
        }
        layerRules.enabledLayers.forEach { layerType in
            guard var parknavLayer =  layerRules.configureLayer(layerType.type) else {return}
            if let configuration = configuration {
                parknavLayer = configuration(parknavLayer)
            }
            getLayer(parknavLayer, countOfTries: 0)
                .onSuccess { shapeObject in
                    parknavLayer.displayOnMap(map, shapeCollection: shapeObject)
                }.onFailure { error in
                    print(error)
            }
        }
    }
}
