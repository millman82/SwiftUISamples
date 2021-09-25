//
//  SearchBar.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/23/21.
//

import SwiftUI

@available(iOS, introduced: 13, obsoleted: 15)
struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    @State private var textFieldAnimation: Animation?
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $text)
                    .padding(10)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing && self.text.count > 0 {
                                Button {
                                    self.text = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .animation(textFieldAnimation)
                    .onTapGesture {
                        self.textFieldAnimation = .default
                        self.isEditing = true
                    }
                
                if isEditing {
                    Button {
                        self.isEditing = false
                        self.text = ""
                        
                        self.textFieldAnimation = .default
                        
                        // Dismiss the keyboard
                        UIApplication.shared
                            .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } label: {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
        }
        .padding(.bottom, 8)
    }
}

@available(iOS, introduced: 13, obsoleted: 15)
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
