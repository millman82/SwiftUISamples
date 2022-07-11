//
//  ValidationSampleView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 10/12/21.
//

import SwiftUI

struct ValidationSampleView: View {
    @Environment(\.sampleService) var sampleService
    @State private var value = ""
    
    var body: some View {
        NavigationView {
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
                        .cornerRadius(8)
                    Spacer()
                }
                Spacer()

            }
            .padding()
            .navigationTitle("Validation")
        }
    }
}

struct ValidationSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationSampleView()
        
        ValidationSampleView().preferredColorScheme(.dark)
    }
}
