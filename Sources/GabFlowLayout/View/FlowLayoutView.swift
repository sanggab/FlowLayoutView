//
//  FlowLayoutView.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI

public struct FlowLayoutView<Style: FlowLayoutStyle>: View {
    @ObservedObject private var viewModel: FlowViewModel<Style.Element> = .init()
    
//    public var style: Style
    
    public init(style: Style) {
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
