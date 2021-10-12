//
//  SearchBarSampleView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 10/12/21.
//

import SwiftUI

struct SearchBarSampleView: View {
    @State private var names = ["Tim", "Jon", "Will", "Chad", "Sara", "Steve", "Megan"]
    @State private var searchText = ""
    @State private var isRefreshing = false
    
    private var filteredNames: [String] {
        if !searchText.isEmpty {
            return names.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
        
        return names
    }
    
    var body: some View {
        NavigationView {
            VStack {
                let list = List {
                    ForEach(filteredNames, id: \.self) { name in
                        Text(name)
                    }
                }
                    .listStyle(GroupedListStyle())
                
                if #available(iOS 15, *) {
                    list
                        .refreshable {
                            print("Refreshing...")
                        }
                        .searchable(text: $searchText)
                } else {
                    SearchBar(text: $searchText)
                    list
                        .pullToRefresh(isRefreshing: $isRefreshing) {
                            print("Refreshing...")
                        }
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchBarSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarSampleView()
        
        SearchBarSampleView().preferredColorScheme(.dark)
    }
}
