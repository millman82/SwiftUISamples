//
//  SumWithCombineView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 10/12/21.
//

import SwiftUI

struct SumWithCombineSampleView: View {
    @StateObject var viewModel: SumWithCombineSampleViewModel = SumWithCombineSampleViewModel()
    
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

struct SumWithCombineSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SumWithCombineSampleView()
        
        SumWithCombineSampleView().preferredColorScheme(.dark)
    }
}
