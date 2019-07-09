//
//  NewsListViewController.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import UIKit

class NewsListViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    fileprivate var viewModel:NewsListViewModel = NewsListViewModel()
    fileprivate var listModel :NewsModel = NewsModel()
    fileprivate let networkManager = NewsNetworkManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.configureData()
        configureTableView()
    }

    func configureTableView(){
        tableView.register(UINib(nibName: NewsListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsListTableViewCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
 

}

extension NewsListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as! NewsListTableViewCell
        cell.viewModel = viewModel.newsDetailForItem(index: indexPath.row)
        return cell
    }


}

extension NewsListViewController : NewsViewModelDelegate {
    func showDetailsiewControllerAt(article: NewsItemViewModel) {
        let viewController = NewsDetailsViewController.instantiateFromStoryboard()
        navigationController?.pushViewController(viewController, animated: true)

    }
    func reloadData() {
        self.tableView.reloadData()
    }





}
