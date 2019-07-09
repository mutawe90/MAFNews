//
//  BaseRouter.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//


import Alamofire

public typealias JSONDictionary = [String: AnyObject]
typealias APIParams = [String : AnyObject]?

protocol APIConfiguration
{
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseURLString: String { get }
    var requestHeaders : [String : Any] { get }
}

class BaseRouter : URLRequestConvertible, APIConfiguration
{

    init() {}

    var method: Alamofire.HTTPMethod {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }

    var encoding: Alamofire.ParameterEncoding? {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }

    var path: String {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }

    var parameters: APIParams {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }

    var baseURLString: String {
        return EnviromentManager.shared.BaseURL
    }

    var requestHeaders : [String : Any]{
        let headers =  ["Content-Type" : "application/json", "Accept" : "application/json"]
        return headers
    }

    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    func asURLRequest() throws -> URLRequest {

        let url = URL(string: baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue


        for (key,value) in requestHeaders
        {
            urlRequest.setValue(value as? String, forHTTPHeaderField: key)
        }
        print("----------------------------------------------------------------------------")
        print("Request :")
        print(urlRequest)
        print("Parameters :")
        print(parameters as Any)
        print("----------------------------------------------------------------------------")
        if encoding != nil
        {
            return try encoding!.encode(urlRequest, with: parameters)
        }
        else
        {
            return urlRequest
        }
    }
}
