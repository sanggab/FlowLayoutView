//
//  ViewModel.swift
//  GabFlowLayout
//
//  Created by Gab on 2024/07/10.
//

import SwiftUI

protocol FlowFeatures {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    
    func callAsFunction<V: Equatable>(_ keyPath: KeyPath<State, V>) -> V
    
    func action(_ action: Action)
}


class FlowLayoutViewModel: ObservableObject, FlowFeatures {
    typealias State = FlowState
    typealias Action = FlowAction
    
    
    struct FlowState: Equatable {
        
        var configuration: FlowConfiguration = .zero
        
        var isOn: Bool = false
        var layoutMode: FlowLayoutMode = .none
        
    }
    
    enum FlowAction: Equatable {
        case updConfiguration(FlowConfiguration)
        case updLayoutMode(FlowLayoutMode)
        case updIsOn(Bool)
    }
    
    @Published private var state: FlowState = .init()
    
    func callAsFunction<V>(_ keyPath: KeyPath<State, V>) -> V where V : Equatable {
        return state[keyPath: keyPath]
    }
    
    func action(_ action: Action) {
        switch action {
        case .updConfiguration(let config):
            update(\.configuration, value: config)
            
        case .updLayoutMode(let mode):
            update(\.layoutMode, value: mode)
            
        case .updIsOn(let state):
            update(\.isOn, value: state)
        }
    }
}

extension FlowLayoutViewModel {
    private func update<V>(_ keyPath: WritableKeyPath<State, V>, value: V) where V: Equatable {
        state[keyPath: keyPath] = value
    }
}
