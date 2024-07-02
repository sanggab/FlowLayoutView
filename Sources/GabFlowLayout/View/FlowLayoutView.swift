//
//  FlowLayoutView.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI

public struct FlowLayoutView<Style: FlowLayoutStyle, ContentView: View>: View {
    @ObservedObject private var viewModel: FlowLayoutViewModel<Style.Element> = .init()
    
    @ViewBuilder private var content: (Style.Element) -> ContentView
    
    public init(item: [Style.Element],
                configuration: FlowConfiguration = .zero,
                alignment: FlowAlignment = .leading,
                @ViewBuilder content: @escaping (Style.Element) -> ContentView) {
        self.content = content
        viewModel.action(.updateModel(FlowLayoutModel(item: item,
                                                      configuration: configuration,
                                                      alignment: alignment)))
    }
    
    public init(style: Style,
                @ViewBuilder content: @escaping (Style.Element) -> ContentView) {
        self.content = content
        viewModel.action(.updateModel(FlowLayoutModel(item: style.item.list,
                                                      configuration: style.configuration,
                                                      alignment: style.alignment)))
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                
            }
    }
}
