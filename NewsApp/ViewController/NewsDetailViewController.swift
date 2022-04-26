//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Chathurika Bandara on 4/26/22.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: EnhancedUIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var linkButton: UIButton!
    
    var article: ArticleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    func setUpUI() {
        linkButton.layer.cornerRadius = 25
        titleLabel.text = article.title
        descriptionLabel.text = article.content
        authorLabel.text = article.author
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'hh:mm:ss'Z'"
        if let date = dateFormatter.date(from: article.publishedAt ?? "") {
            dateFormatter.dateFormat = "dd MMMM yyyy, hh:mm a"
            dateLabel.text = dateFormatter.string(from: date)
        }
        linkButton.isHidden = article.url == nil
        spinner.isHidden = false
        newsImageView.downloadImage(from: article.urlToImage, defaultImage: UIImage(named: "NoImageAvailable")) {
            _ in
            self.spinner.isHidden = true
        }
    }
    
    @IBAction func linkButtonAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            vc.urlString = article.url
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
