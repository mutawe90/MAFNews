//
//  BaseNetworkManager.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Alamofire
import Connectivity


class BaseNetworkManager : NSObject
{
    typealias SuccessCompletion = (Any) -> Void

    typealias FailureCompletion = (APIError) -> Void

    private let connectivity = Connectivity()

    func performNetworkRequest(forRouter router: BaseRouter , onSuccess: @escaping SuccessCompletion , onFailure: @escaping FailureCompletion)
    {
        connectivity.checkConnectivity { connectivity in
            switch connectivity.status {

            case .connected, .connectedViaCellular, .connectedViaWiFi:
                self._performNetworkRequest(forRouter: router, onSuccess: onSuccess, onFailure: onFailure)

            case .connectedViaCellularWithoutInternet, .connectedViaWiFiWithoutInternet, .notConnected:
                let apiError = APIError()
                apiError.message = kNoInternetMessage
                onFailure(apiError)
            }
        }
     }

    fileprivate func _performNetworkRequest(forRouter router: BaseRouter , onSuccess: @escaping SuccessCompletion , onFailure: @escaping FailureCompletion)
    {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

        let sessionManager = Alamofire.SessionManager(
            configuration: configuration
        )


         sessionManager.request(router)
            .validate()
            .responseString(completionHandler: { (response) in

            })
            .responseJSON { (response) in
                sessionManager.session.invalidateAndCancel()

                switch response.result
                {
                case .success( _):

                    return onSuccess(response.result.value!)
                case .failure(_):

                    let apiError = APIError()

                    if response.data != nil
                    {
                        apiError.response = response.data!
                    }

                    if let error = response.result.error as? AFError
                    {
                        apiError.responseStatusCode = error._code // statusCode private

                        let localizedDescription : String = "An error has occurred please try again"
                        var failureReason : String?
                        switch error
                        {
                        case .invalidURL(let url):

                            failureReason = "Invalid URL: \(url) - \(error.localizedDescription)"
                            print("Invalid URL: \(url) - \(error.localizedDescription)")

                        case .parameterEncodingFailed(let reason):
                            failureReason = "Failure Reason: \(reason)"

                        case .multipartEncodingFailed(let reason):
                            failureReason = "Failure Reason: \(reason)"

                        case .responseValidationFailed(let reason):
                            failureReason = "Failure Reason: \(reason)"

                            switch reason
                            {
                            case .dataFileNil, .dataFileReadFailed:
                                failureReason = "Downloaded file could not be read"
                            case .missingContentType(let acceptableContentTypes):
                                failureReason = "Content Type Missing: \(acceptableContentTypes)"

                            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                                failureReason = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                            case .unacceptableStatusCode(let code):
                                failureReason = "Response status code was unacceptable: \(code)"
                                apiError.responseStatusCode = code
                            }
                        case .responseSerializationFailed(let reason):
                            failureReason = "Failure Reason: \(reason)"
                        }

                        apiError.message = localizedDescription
                        apiError.extraDescription = failureReason
                    }
                    else if let error = response.result.error as? URLError
                    {
                        print("URLError occurred: \(error)")
                        apiError.error = error
                    }
                    else
                    {
                        print("Unknown error: \(String(describing: response.result.error))")
                    }

                    return onFailure(apiError)
                }
        }

    }

}


