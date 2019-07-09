//
//  NewsModel.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper

struct NewsModel : Mappable {
    var status : String?
    var totalResults : Int?
    var articles : [ArticleModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        totalResults <- map["totalResults"]
        articles <- map["articles"]
    }

}
