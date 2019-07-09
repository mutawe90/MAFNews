
//
//  NewsItemViewModel.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation
class NewsItemViewModel {

    // MARK: - Properties
    var newsTitle:String
    var newsDescription:String
    var newsDate:String
    var model:ArticleModel
    var imageURL: URL? {
        guard let imageUrl = model.urlToImage else {
            return nil
        }
        return URL(string:imageUrl)
    }

    // MARK: - Initialization
    init(article:ArticleModel) {
        model = article
        newsTitle = article.title ?? ""
        newsDescription = article.newsDescription ?? ""
        newsDate = article.publishedAt ?? ""
        if let dateString = article.publishedAt{
            let date = Date(fromString: dateString, format: .isoDateTimeSec)
            newsDate = (date?.toString(style: DateStyleType.medium))!
        }

    }

}
