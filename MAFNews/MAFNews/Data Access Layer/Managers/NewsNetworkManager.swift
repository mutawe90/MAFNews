//
//  NewsNetworkManager.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsNetworkManager: BaseNetworkManager
{


    func getTopNewsHeadLines(country: String,  onSuccess: @escaping (NewsModel)->Void, onFailure: @escaping  (APIError)->Void) {
        let newsRouter = NewsRouter(endpoint: .GetAllNews(country: country))

        super.performNetworkRequest(forRouter: newsRouter, onSuccess: { (responseObject) in

            guard let responseDictionary = responseObject as? [String : Any] else {
                onFailure(APIError())
                return
            }


            let model = Mapper<NewsModel>().map(JSONObject: responseDictionary)

            onSuccess(model!)

        }) { (apiError) in
            print(apiError.message as Any)
            onFailure(apiError)
        }
    }




}
