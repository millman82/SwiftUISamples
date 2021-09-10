//
//  ContentView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var value = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world!")
            TextField("Enter 10 characters or less", text: $value)
                .validated(isValid: {
                    value.count < 11
                    
                }, validationMessage: "Too many!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
