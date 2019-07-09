//
//  ViewController.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let networkManager = NewsNetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager.getTopNewsHeadLines(country: "AE", onSuccess: { (models) in

        }) { (error) in
            
        }
        // Do any additional setup after loading the view.
    }


}

