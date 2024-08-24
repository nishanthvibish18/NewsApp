//
//  ApiRequestService.swift
//  NewsAppSwiftUI
//
//  Created by Nishanth on 24/08/24.
//

import Foundation

struct ApiRequestService{
    
   static var NewsChannelListAPI: ApiBuilder<NewsModel>{
        return ApiBuilder(url: NetworkURL.channelList.rawValue)
    }
    static func headLineNewsList(source: String) -> ApiBuilder<NewsListModel>{
        let headlineNews = NetworkURL.headlineNews.rawValue
        let urlString = headlineNews.replacingOccurrences(of: "newsid", with: source)
        return ApiBuilder(url: urlString)
    }
}
