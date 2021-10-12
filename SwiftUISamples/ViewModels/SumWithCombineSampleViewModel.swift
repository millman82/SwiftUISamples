//
//  SumWithCombineViewModel.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 10/12/21.
//

import Combine

final class SumWithCombineSampleViewModel: ObservableObject {
    @Published var firstNumber = ""
    @Published var secondNumber = ""
    @Published var sum = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        initObservables()
    }
    
    private func initObservables() {
        // OPTION: 1
//        Publishers.CombineLatest($firstNumber, $secondNumber)
//            .compactMap { (first, second) in
//                guard let firstNum = Int(first), let secondNum = Int(second) else {
//                    return 0
//                }
//
//                return firstNum + secondNum
//            }
//            .assign(to: &self.$sum)
        
        // OPTION: 2
        Publishers.CombineLatest($firstNumber, $secondNumber)
            .sink(receiveValue: { (first, second) in
                guard let firstNum = Int(first), let secondNum = Int(second) else {
                    self.sum = 0
                    return
                }
                
                self.sum = firstNum + secondNum
            })
            .store(in: &subscriptions)
    }
}
