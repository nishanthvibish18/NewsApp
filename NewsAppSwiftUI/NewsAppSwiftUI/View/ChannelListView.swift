//
//  ChannelListView.swift
//  NewsAppSwiftUI
//
//  Created by Nishanth on 24/08/24.
//

import SwiftUI

struct ChannelListView: View {
    @StateObject private var stateListArray: ChannelListViewModel = ChannelListViewModel()
    var body: some View {
       
        List {
            ForEach(stateListArray.channelListVMArray, id: \.id) { data in
                NavigationLink(destination: NewsListView(source: data)) {
                    ChannelCellListView(channelListMode: data)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Channel List")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task{
                        await self.stateListArray.apiCall()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                }

            }
        }
        .task {
           await self.stateListArray.apiCall()
        }
    }
}

#Preview {
    ChannelListView()
}

//MARK: Channel List Cell
struct ChannelCellListView: View {
    let channelListMode: ChannelListVM
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text(channelListMode.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(channelListMode.description)
        }
    }
}
