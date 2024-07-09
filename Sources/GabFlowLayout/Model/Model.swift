//
//  Model.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/02.
//

import SwiftUI

@frozen
public struct FlowConfiguration: Equatable {
    public static let zero = FlowConfiguration(lineSpacing: .zero, itemSpacing: .zero)
    
    var lineSpacing: CGFloat
    var itemSpacing: CGFloat
    
    public init(lineSpacing: CGFloat, itemSpacing: CGFloat) {
        self.lineSpacing = lineSpacing
        self.itemSpacing = itemSpacing
    }
}
