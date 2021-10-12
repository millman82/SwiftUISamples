//
//  SumWithCombineView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 10/12/21.
//

import SwiftUI

struct SumWithCombineView: View {
    @StateObject var viewModel: SumWithCombineViewModel = SumWithCombineViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("First number", text: $viewModel.firstNumber)
                .keyboardType(.numberPad)
            TextField("Second number", text: $viewModel.secondNumber)
                .keyboardType(.numberPad)
            Text("Sum: \(viewModel.sum)")
            Spacer()
        }
        .padding()
    }
}

struct SumWithCombineView_Previews: PreviewProvider {
    static var previews: some View {
        SumWithCombineView()
        
        SumWithCombineView().preferredColorScheme(.dark)
    }
}
