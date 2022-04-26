//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Chathurika Bandara on 4/26/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: EnhancedUIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var article: ArticleModel! {
        didSet {
            self.setCellValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        spinner.isHidden = true
        imageView?.layer.cornerRadius = 4.0
    }
    func setCellValues() {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'hh:mm:ss'Z'"
        if let date = dateFormatter.date(from: article.publishedAt ?? "") {
            dateFormatter.dateFormat = "dd MMMM yyyy, hh:mm a"
            dateLabel.text = dateFormatter.string(from: date)
        }
        spinner.isHidden = false
        newsImageView.downloadImage(from: article.urlToImage, defaultImage: UIImage(named: "NoImageAvailable")) {
            _ in
            self.spinner.isHidden = true
        }
    }
    
}
