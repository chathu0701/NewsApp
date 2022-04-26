//
//  Model.swift
//  NewsApp
//
//  Created by Chathurika Bandara on 4/26/22.
//

import Foundation
struct NewsListResponseModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleModel]
}

struct ArticleModel: Codable {
    var source: SourceModel
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

}

struct SourceModel: Codable {
    var id: String?
    var name: String?
}
