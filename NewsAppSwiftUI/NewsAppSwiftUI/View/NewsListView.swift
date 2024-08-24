//
//  NewsListView.swift
//  NewsAppSwiftUI
//
//  Created by Nishanth on 24/08/24.
//

import SwiftUI

struct NewsListView: View {
    let source: ChannelListVM
    @StateObject private var newsListVm: NewsListViewModel = NewsListViewModel()
    var body: some View {
        List {
            ForEach(newsListVm.channelListVMArray, id: \.id){ data in
                NewsListViewCell(data: data)
            }
        }
        .listStyle(.plain)
        .task {
            await self.newsListVm.apiCall(source: source.statusID)
        }
        .navigationTitle(source.name)
    }
}



//MARK: News List Cell
struct NewsListViewCell: View {
    let data: NewsListVM
    var body: some View {
        HStack(alignment: .top,spacing: 18) {
            AsyncImage(url: data.urlImage) { image in
                image.resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
            } placeholder: {
                ProgressView("Loading...")
                    .frame(maxWidth: 100, maxHeight: 100)
            }.clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading,spacing: 10) {
                Text(data.name)
                    .fontWeight(.bold)
                Text(data.description)                
            }
        }
    }
}
