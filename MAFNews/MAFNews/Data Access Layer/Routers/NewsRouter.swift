//
//  NewsRouter.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation
import Alamofire

enum NewsEndpoint {
    case GetAllNews (country : String )

}
class NewsRouter: BaseRouter
{
    var endpoint: NewsEndpoint

    init(endpoint:NewsEndpoint)
    {
        self.endpoint = endpoint
    }

    override var method: HTTPMethod
    {
        switch endpoint {
        case .GetAllNews:
            return .get

        }
    }

    override var path: String{

        switch endpoint {
        case .GetAllNews:
            return "top-headlines"
        }
    }

    override var encoding: ParameterEncoding?{
        return URLEncoding.default
    }

    override var parameters: APIParams{
        switch endpoint {
        case .GetAllNews(let country):
            return ["country" : country as AnyObject , "ApiKey" : kAPIKey as AnyObject]
        }
    }

    override var requestHeaders: [String : Any]{
        switch endpoint {
        default:
            return ["content-type" : "application/json" , "Accept" : "application/json"]
        }
    }
}
