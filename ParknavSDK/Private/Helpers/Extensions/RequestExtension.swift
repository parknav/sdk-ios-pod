//
//  RequestExtension.swift
//  ParknavSDK
//

import Foundation
import Alamofire

extension DataRequest {
    private func parseErrors(json: [String: AnyObject]) -> NSError? {
        guard let errorMessage = json["message"] as? String,
              let statusCode = json["statusCode"] as? Int else {
            return nil
        }
        return NSError(domain: ParknavConstans.API.projectName,
                       code: statusCode,
                       userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }

    private func genericResponse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<Any> {
        guard response != nil else { return .failure(ParknavConstans.Errors.internetError) }
        guard error == nil else { return .failure(BackendError.network(error: error!)) }

        guard let responseData = data else {
            _ = "Object could not be serialized because input data was nil."
            let error = AFError.responseSerializationFailed(reason: .inputDataNil)
            return .failure(BackendError.dataSerialization(error: error))
        }

        let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
        let result = jsonResponseSerializer.serializeResponse(request, response, responseData, nil)

        guard case .success(_) = result else { return .failure(BackendError.jsonSerialization(error: result.error!)) }

        if let value = result.value {
            if (response!.statusCode > 300 || response!.statusCode < 200), let json = value as? [String: AnyObject] {
                if let parsedError = self.parseErrors(json: json) {
                    return .failure(parsedError)
                }
            }
            return .success(value)
        }

        return .failure(result.error!)
    }

    func responseDictionary(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[String: AnyObject]>) -> Void)
        -> Self {
            let responseSerializer = DataResponseSerializer<[String: AnyObject]> { [weak self] request, response, data, error in
                guard let self = self else { return .failure(ParknavConstans.Errors.selfError) }
                let result = self.genericResponse(request: request, response: response, data: data, error: error)
                if result.isSuccess {
                    if let value = result.value {
                        if let json = value as? [String: AnyObject] {
                            return .success(json)
                        }
                        if value is NSNull {
                            return .success([String: AnyObject]())
                        }
                    }
                    let error = AFError.responseSerializationFailed(reason: .inputDataNil)
                    return .failure(BackendError.jsonSerialization(error: error))
                }

                return .failure(result.error!)
            }

            return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }

    func responseDataObject(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<Data>) -> Void)
        -> Self {
            let responseSerializer = DataResponseSerializer<Data> { [weak self] request, response, data, error in
                guard let self = self else { return .failure(ParknavConstans.Errors.selfError) }
                let result = self.genericResponse(request: request, response: response, data: data, error: error)
                if result.isSuccess {
                    if let data = data {
                        return .success(data)
                    }
                    let error = AFError.responseSerializationFailed(reason: .inputDataNil)
                    return .failure(BackendError.jsonSerialization(error: error))
                }
                return .failure(result.error!)
            }

        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }

    func responseJSONObject<T: JSONSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {
            let responseSerializer = DataResponseSerializer<T> { [weak self] request, response, data, error in
                guard let self = self else { return .failure(ParknavConstans.Errors.selfError) }
                let result = self.genericResponse(request: request, response: response, data: data, error: error)
                if result.isSuccess {
                    if let value = result.value {
                        if let json = value as? [String: AnyObject] {
                            if let resultObject = T(json: json) {
                                return .success(resultObject)
                            }
                        }
                    }
                    let error = AFError.responseSerializationFailed(reason: .inputDataNil)
                    return .failure(BackendError.jsonSerialization(error: error))
                }
                return .failure(result.error!)
            }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }

    func responseObject<T: ResponseObjectSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {
            let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
                guard error == nil else { return .failure(BackendError.network(error: error!)) }

                let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
                let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)

                guard case let .success(jsonObject) = result else {
                    return .failure(BackendError.jsonSerialization(error: result.error!))
                }

                guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
                    return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
                }
                return .success(responseObject)
            }
            return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }

    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }

            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)

            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }

            guard let response = response else {
                let reason = "Response collection could not be serialized due to nil response."
                return .failure(BackendError.objectSerialization(reason: reason))
            }

            return .success(T.collection(from: response, withRepresentation: jsonObject))
        }

        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
