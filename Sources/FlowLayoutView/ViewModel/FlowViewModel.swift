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


class FlowViewModel<E: Equatable>: ObservableObject, FlowFeatures {
    typealias State = FlowState
    typealias Action = FlowAction
    
    struct FlowState: Equatable {
        var model: FlowLayoutModel<E> = .init(item: [])
        var isUpdated: UUID = UUID()
    }
    
    enum FlowAction: Equatable {
        case onAppear
        
        case updateModel(FlowLayoutModel<E>)
    }
    
    @Published private var state: FlowState = .init()
    
    
    
//    init(model: FlowLayoutModel<E>) {
//        self.state = FlowState(model: model)
//    }
    
    
    func callAsFunction<V>(_ keyPath: KeyPath<FlowState, V>) -> V where V : Equatable {
        return state[keyPath: keyPath]
    }
    
    func action(_ action: FlowAction) {
        switch action {
        case .onAppear:
            print("onAppear")
        case .updateModel(let model):
            print("updateModel : \(model)")
            update(\.model, newValue: model)
            print("staet model : \(state.model)")
        }
    }
    
    private func update<V>(_ keyPath: WritableKeyPath<FlowState, V>, newValue: V) {
        state[keyPath: keyPath] = newValue
    }
}
