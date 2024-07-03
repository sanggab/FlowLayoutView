//
//  FlowLayoutViewModel.swift
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


class FlowLayoutViewModel<E: Equatable>: ObservableObject, FlowFeatures {
    typealias State = FlowState
    typealias Action = FlowAction
    typealias Line = Int
    
    struct FlowState: Equatable {
        var model: FlowLayoutModel<E> = .init(item: [])
        var isUpdated: UUID = UUID()
        
        var index: Int = .zero
        var currentLineWidth: CGFloat = .zero
        var currentLineHeight: CGFloat = .zero
        var alignments: [CGSize] = []
    }
    
    enum FlowAction: Equatable {
        case updateModel(FlowLayoutModel<E>)
        
        case updateIndex(Int)
        case updateAlignment(CGSize)
        case updateCurrentLineWidth(CGFloat)
        case updatecurrentLineHeight(CGFloat)
        
        case reset
    }
    
    @Published private var state: FlowState = .init()
    
    
    
//    init(model: FlowLayoutModel<E>) {
//        self.state = FlowState(model: model)
//    }
    
    
    func callAsFunction<V>(_ keyPath: KeyPath<FlowState, V>) -> V where V : Equatable {
        return state[keyPath: keyPath]
    }
    
    func action(_ action: FlowAction) {
        print("action : \(action)")
        switch action {
        case .updateModel(let model):
            update(\.model, newValue: model)
            print("staet model : \(state.model)")
            
        case .updateIndex(let index):
            state.index = index
            print("state.index : \(state.index)")
            
        case .updateAlignment(let size):
            state.alignments.append(size)
            print("state.alignments : \(state.alignments)")
            
        case .updateCurrentLineWidth(let width):
            state.currentLineWidth += width
            
        case .updatecurrentLineHeight(let height):
            state.currentLineHeight += height
            
        case .reset:
            state.alignments = []
            state.currentLineWidth = .zero
            state.currentLineHeight = .zero
            print("state.alignments : \(state.alignments)")
        }
    }
    
    private func update<V>(_ keyPath: WritableKeyPath<FlowState, V>, newValue: V) {
        state[keyPath: keyPath] = newValue
    }
}
