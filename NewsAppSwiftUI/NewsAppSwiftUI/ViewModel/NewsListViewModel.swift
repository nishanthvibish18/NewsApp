//
//  NewsListViewModel.swift
//  NewsAppSwiftUI
//
//  Created by Nishanth on 24/08/24.
//

import Foundation


@MainActor
class NewsListViewModel: ObservableObject{
    @Published var channelListVMArray: [NewsListVM] = []
    
    
    func apiCall(source: String) async{
        do{
            let result = try await Webservice.sharedInstance.webRequest(apiRequestBuilder: ApiRequestService.headLineNewsList(source: source))
            
            if let response = result{
                let resultArray = response.articles ?? []
                self.channelListVMArray = resultArray.map(NewsListVM.init)
            }
        }
        catch let error{
            print(error)
        }
    }
}

struct NewsListVM{
    let channelList: Articles
    
    var name: String{
        return channelList.title ?? ""
    }
    var url: String{
        return channelList.url ?? ""
    }
    var urlImage: URL?{
        return URL(string: channelList.urlToImage ?? "")
    }
    var id: UUID{
        return UUID(uuidString: channelList.description ?? "") ?? UUID()
    }
    var description: String{
        return channelList.description ?? ""
    }
    
    
}
