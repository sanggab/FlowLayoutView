//
//  FlowLayoutView.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI

public struct FlowLayoutView<Style: FlowLayoutStyle>: View {
    
    public var style: Style
    
    public init(style: Style) {
        self.style = style
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
