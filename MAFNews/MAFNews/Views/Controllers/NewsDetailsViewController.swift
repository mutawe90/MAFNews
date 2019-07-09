//
//  NewsDetailsViewController.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import UIKit

class NewsDetailsViewController: BaseViewController {

    var articleViewModel : NewsItemViewModel!

    // MARK: - static methods
    static func instantiateFromStoryboard() -> NewsDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


 

}
