//
//  ViewController.swift
//  NewsApp
//
//  Created by Chathurika Bandara on 4/26/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var articleList: [ArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.retrieveNews()
    }
    
    private func retrieveNews() {
        AF.request("http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f4e8d206d0874868b6622b64327409c5")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    if let newsList = try? JSONDecoder().decode(NewsListResponseModel.self, from: response.value!) {
                        self.articleList = newsList.articles
                        self.tableView.reloadData()
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
    private func navigateToDetailView(article: ArticleModel) {
        if let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController {
            vc.article = article
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        tableCell.article = articleList[indexPath.row]
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToDetailView(article: articleList[indexPath.row])
    }
    
}
