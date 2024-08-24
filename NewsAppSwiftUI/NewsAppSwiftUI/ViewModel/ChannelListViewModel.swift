//
//  ChannelListViewModel.swift
//  NewsAppSwiftUI
//
//  Created by Nishanth on 24/08/24.
//

import Foundation

@MainActor
class ChannelListViewModel: ObservableObject{
    @Published var channelListVMArray: [ChannelListVM] = []
    
    
    func apiCall() async{
        do{
            let result = try await Webservice.sharedInstance.webRequest(apiRequestBuilder: ApiRequestService.NewsChannelListAPI)
            
            if let response = result{
                let resultArray = response.sources ?? []
                self.channelListVMArray = resultArray.map(ChannelListVM.init)
            }
        }
        catch let error{
            print(error)
        }
    }
}

struct ChannelListVM{
    let channelList: Sources
    
    var name: String{
        return channelList.name ?? ""
    }
    var statusID:String{
        return self.channelList.id ?? ""
    }
    
    var id: UUID{
        return UUID(uuidString: channelList.id ?? "") ?? UUID()
    }
    var description: String{
        return channelList.description ?? ""
    }
    

}
