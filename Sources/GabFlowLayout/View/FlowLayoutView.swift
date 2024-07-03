//
//  FlowLayoutView.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI

public struct FlowLayoutView<E: Equatable, ContentView: View>: View {
    @ObservedObject private var viewModel: FlowLayoutViewModel<E> = .init()
    
//    @ViewBuilder private var content: (E) -> ContentView
    @ViewBuilder private var content: (E) -> ContentView
    
    public init(item: [E],
                configuration: FlowConfiguration = .zero,
                alignment: FlowAlignment = .leading,
                @ViewBuilder content: @escaping (E) -> ContentView) {
        self.content = content
        viewModel.action(.updateModel(FlowLayoutModel(item: item,
                                                      configuration: configuration,
                                                      alignment: alignment)))
    }
    
//    public init(item: [Style.Element],
//                configuration: FlowConfiguration = .zero,
//                alignment: FlowAlignment = .leading,
//                @ViewBuilder content: @escaping (Style.Element) -> ContentView) {
//        self.content = content
//        viewModel.action(.updateModel(FlowLayoutModel(item: item,
//                                                      configuration: configuration,
//                                                      alignment: alignment)))
//    }
//    
//    public init(style: Style,
//                @ViewBuilder content: @escaping (Style.Element) -> ContentView) {
//        self.content = content
//        viewModel.action(.updateModel(FlowLayoutModel(item: style.item.list,
//                                                      configuration: style.configuration,
//                                                      alignment: style.alignment)))
//    }
    
    public var body: some View {
        if viewModel(\.model).alignment == .leading {
            leadingAlignmentView
        } else {
            trailingAlignmentView
        }
    }
}


private extension FlowLayoutView {
    
    @ViewBuilder
    var leadingAlignmentView: some View {
        ZStack {
            ForEach(Array(viewModel(\.model).item.list.enumerated()), id: \.offset) { index, item in
                content(item)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.orange)
    }
}

private extension FlowLayoutView {
    
    @ViewBuilder
    var trailingAlignmentView: some View {
        Text("trailingAlignmentView")
    }
}
