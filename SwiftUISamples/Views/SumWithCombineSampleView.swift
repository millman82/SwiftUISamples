//
//  SumWithCombineView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 10/12/21.
//

import SwiftUI

struct SumWithCombineSampleView: View {
    @Environment(\.appEnvironment) var appEnvironment

    @StateObject var viewModel: SumWithCombineSampleViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("First number", text: $viewModel.firstNumber)
                .keyboardType(.numberPad)
            TextField("Second number", text: $viewModel.secondNumber)
                .keyboardType(.numberPad)
            Text("Sum: \(viewModel.sum)")
            Text("AppEnvironment: \(appEnvironment.rawValue)")
            Spacer()
        }
        .padding()
    }
}

struct SumWithCombineSampleView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleService = SampleServiceImpl(logger: LoggerImpl(appEnvironment: .dev))

        SumWithCombineSampleView(viewModel: SumWithCombineSampleViewModel(sampleService: sampleService))
        
        SumWithCombineSampleView(viewModel: SumWithCombineSampleViewModel(sampleService: sampleService))
            .preferredColorScheme(.dark)
    }
}
