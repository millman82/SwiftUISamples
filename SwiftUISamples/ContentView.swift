//
//  ContentView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/3/21.
//

import SwiftUI

struct ContentView: View {
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
        }
    }
}

struct ValidationSampleView: View {
    @State private var value = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Prompt")
            TextField("Prompt", text: $value)
                .validated(isValid: {
                    value.count < 11

                }, validationMessage: "Too many!")
            
            HStack {
                Spacer()
                Button("Test Button", action: {})
                    .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
                    .background(Color.blue)
                    .foregroundColor(.white)
                Spacer()
            }
            
        }
        .padding()
        
//        List {
//            ForEach(0..<20) { index in
//                Text("Test")
//            }
//        }
    }
}

struct SearchBarSampleView: View {
    @State private var text = ""
    
    var body: some View {
        SearchBar(text: $text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        ContentView().preferredColorScheme(.dark)
    }
}
