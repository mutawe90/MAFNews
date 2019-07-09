//
//  NewsListViewModel.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation

protocol NewsViewModelDelegate :NSObject{


    func reloadData()
    func showDetailsiewControllerAt(article:NewsItemViewModel)
    func reloadDataFromPullToRefresh()
}

class NewsListViewModel {

    // MARK: - Variables
     weak var delegate:NewsViewModelDelegate?
    fileprivate let networkManager = NewsNetworkManager()
    var dataSource = [NewsItemViewModel]()

    // MARK: - Helper Methods
    func configureData(){

        networkManager.getTopNewsHeadLines(country: kUAE, onSuccess: { (newsModel) in
            self.delegate?.reloadDataFromPullToRefresh()
            if let status = newsModel.status, status.uppercased() == kStatusOk{
                self.configureDataSource(models: newsModel.articles!)
            }
        }) { (apiError) in
            self.delegate?.reloadDataFromPullToRefresh()
        }

    }

    fileprivate func configureDataSource(models: [ArticleModel]) {
        dataSource.removeAll()

        for article in models{
            let model = NewsItemViewModel(article: article)
            dataSource.append(model)
        }
        delegate?.reloadData()
    }
    // MARK: - Refresh Action
    func reloadNews(){
        configureData()
    }

    // MARK: - TableView Helper Methods
    func numberOfSections() -> Int{
        return 1
    }

    func numberOfRowsIn(section:Int) -> Int{
         return dataSource.count
    }

    func newsDetailForItem(index:Int) -> (NewsItemViewModel){
        return dataSource[index]
    }

    func handleSelectonFor(row:Int){
        self.delegate?.showDetailsiewControllerAt(article: dataSource[row])
    }



}
