//
//  NewsListTableViewCell.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import UIKit
import SDWebImage

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsDescriptionConstraint: NSLayoutConstraint!

    var viewModel:NewsItemViewModel?{
        didSet{
            if let _ = viewModel{
                bindUI()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func bindUI(){
        newsTitleLabel.text = viewModel?.newsTitle
        if let description = viewModel?.newsDescription , description.count > 0 {
            newsDescriptionLabel.text = description
        }
        else{
            newsDescriptionConstraint.constant = 0
        }
        newsDateLabel.text = viewModel?.newsDate
        if let imageURL = viewModel?.imageURL {
           self.newsImageView.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "placeholderImage") , options: .highPriority, completed: nil)

        }

    }

    
}
