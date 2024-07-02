//
//  Model.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/02.
//

import SwiftUI

public protocol FlowLayoutStyle: Equatable {
    associatedtype Element: Equatable
    
    var item: FlowItem<Element> { get }
    var configuration: FlowConfiguration { get }
    var alignment: FlowAlignment { get }
}

public struct FlowItem<E: Equatable>: Equatable {
    var list: [E]
    
    public init(list: [E]) {
        self.list = list
    }
}

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
public enum FlowAlignment: Equatable {
    case leading
    case trailing
}

public struct FlowLayoutModel<E: Equatable>: FlowLayoutStyle {
    public typealias Element = E
    
    public var item: FlowItem<Element>
    public var configuration: FlowConfiguration
    public var alignment: FlowAlignment
    
    public init(item: [Element],
                configuration: FlowConfiguration = .zero,
                alignment: FlowAlignment = .leading) {
        self.item = FlowItem(list: item)
        self.configuration = configuration
        self.alignment = alignment
    }
}
