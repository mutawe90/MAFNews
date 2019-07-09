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
protocol BaseCommunicationHandlerDelegate :NSObject{
    func addLoadingIndicator()
    func removeLoadingIndicator()
    func showError(message: String, complition: (() -> ())? )
    func showSuccessMessage(message: String, complition: (() -> ())? )
}


class NewsListViewModel {

    // MARK: - Variables
    weak var delegate:NewsViewModelDelegate?
    weak var controlsDelegate: BaseCommunicationHandlerDelegate?
    fileprivate let networkManager = NewsNetworkManager()
    var dataSource = [NewsItemViewModel]()

    // MARK: - Helper Methods
    func configureData(){

        self.controlsDelegate?.addLoadingIndicator()
        networkManager.getTopNewsHeadLines(country: kUSAnewsSource, onSuccess: { (newsModel) in
            self.controlsDelegate?.removeLoadingIndicator()
            self.delegate?.reloadDataFromPullToRefresh()
            if let status = newsModel.status, status.uppercased() == kStatusOk{
                self.configureDataSource(models: newsModel.articles!)
            }
        }) { (apiError) in
            self.controlsDelegate?.removeLoadingIndicator()
            self.controlsDelegate?.showError(message: apiError.message, complition: nil)
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
