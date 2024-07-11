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

@frozen
public enum FlowLayoutMode: Equatable {
    /// Basic 기능
    case none
    
    /// Scroll 기능 - Bool값은 Indicator 여부
    case scroll(Bool)
    
    /// Flexible 기능
//    case flexible
}

public extension FlowLayoutMode {
    var showIndicators: Bool {
        switch self {
        case .none:
            return false
        case .scroll(let bool):
            return bool
//        case .flexible:
//            return false
        }
    }
}
