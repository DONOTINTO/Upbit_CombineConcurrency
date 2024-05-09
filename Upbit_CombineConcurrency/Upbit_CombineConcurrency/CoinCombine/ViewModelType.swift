//
//  ViewModelType.swift
//  Upbit_CombineConcurrency
//
//  Created by 이중엽 on 5/9/24.
//

import Foundation
import Combine

protocol ViewModelType: ObservableObject  {
    
    // associatedtype Input
    // associatedtype Output
    
    // var cancellables: Set<AnyCancellable> { get set }
    
    // var input: Input { get set }
    // var output: Output { get set }
    
    func transform()
}
