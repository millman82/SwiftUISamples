//
//  ContentView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/3/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.logger) var logger
    @Environment(\.sampleService) var sampleService

    init() {
        // Color Tab Bar manually. If we have a list or form the tab bar will
        // get the secondarySystemBackground color applied by default.
        // Option 1
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .secondarySystemBackground

        UITabBar.appearance().standardAppearance = tabBarAppearance

        if #available(iOS 15, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        // Option 2
//        UITabBar.appearance().isTranslucent = false
//        UITabBar.appearance().isOpaque = true
//        UITabBar.appearance().backgroundColor = .secondarySystemBackground
    }
    
    var body: some View {
        TabView {
            ValidationSampleView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Validation")
                }
            
            SearchBarSampleView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            ImageSelectionSampleView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Image Selection")
                }
            
            SumWithCombineSampleView(viewModel: SumWithCombineSampleViewModel(sampleService: sampleService))
                .tabItem {
                    Image(systemName: "plus")
                    Text("Sum with Combine")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        ContentView().preferredColorScheme(.dark)
    }
}
