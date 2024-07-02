//
//  FlowViewModel.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/02.
//

import SwiftUI

protocol FlowFeatures {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    
    func callAsFunction<V: Equatable>(_ keyPath: KeyPath<State, V>) -> V
    
    func action(_ action: Action)
}


class FlowViewModel: ObservableObject, FlowFeatures {
    typealias State = FlowState
    typealias Action = FlowAction
    
    struct FlowState: Equatable {
        
        init() {
            
        }
        
        var isUpdated: UUID = UUID()
    }
    
    enum FlowAction: Equatable {
        case onAppear
    }
    
    @Published private var state: FlowState = .init()
    
    
    func callAsFunction<V>(_ keyPath: KeyPath<FlowState, V>) -> V where V : Equatable {
        return state[keyPath: keyPath]
    }
    
    func action(_ action: FlowAction) {
        
    }
}
