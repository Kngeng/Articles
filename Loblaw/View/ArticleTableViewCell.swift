//
//  ArticleTableViewCell.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-20.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var thumbnailImageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var embededView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        thumbnailImageView.image = nil
        thumbnailImageViewHeightConstraint.constant = 200
        self.thumbnailImageView.setNeedsUpdateConstraints()
        self.thumbnailImageView.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ article: Article, tableView: UITableView) {
        titleLabel.text = article.data.title
        guard article.data.thumbnail != "self" else {
            thumbnailImageViewHeightConstraint.constant = 0
            self.thumbnailImageView.setNeedsUpdateConstraints()
            self.thumbnailImageView.layoutIfNeeded()
            return
        }
        
        let progressView = ProgressView(with: self)
            progressView.show()
            DispatchQueue.global(qos: .userInitiated).async {
                Service.getImage(for: article.data.thumbnail, completion: { result in
                    DispatchQueue.main.async {
                        progressView.hide()
                        if case .success(let image) = result {
                            if tableView.visibleCells.contains(self) {
                                self.thumbnailImageView.image = image
                                //self.thumbnailImageViewHeightConstraint.constant = (image.size.height/image.size.width) * self.thumbnailImageView.bounds.width
                            }
                        }
                    }
                })
            }
    }
}
