//
//  NewsDetailsViewController.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import UIKit
import SafariServices

class NewsDetailsViewController: BaseViewController {
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDesctiptionTextView: UITextView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLanbel: UILabel!

    var articleViewModel : NewsItemViewModel!

    // MARK: - static methods
    static func instantiateFromStoryboard() -> NewsDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    func bindUI() {
        newsTitleLabel.text = articleViewModel?.newsTitle
        if let description = articleViewModel?.newsDescription , description.count > 0 {
            newsDesctiptionTextView.text = description
        }
        dateLanbel.text = articleViewModel?.newsDate
        if let imageURL = articleViewModel?.imageURL {
            self.newImageView.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "placeholderImage") , options: .highPriority, completed: nil)

        }
        sourceLabel.text = articleViewModel.newsSource
    }
 
    @IBAction func openLinkInSafari(_ sender: Any) {
        let svc = SFSafariViewController(url: articleViewModel.newsURL!)
        present(svc, animated: true, completion: nil)

    }
    
}
