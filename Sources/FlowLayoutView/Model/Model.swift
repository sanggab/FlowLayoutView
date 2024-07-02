//
//  Model.swift
//  FlowLayoutView
//
//  Created by Gab on 2024/07/02.
//

import SwiftUI

public protocol FlowLayoutStyle {
    associatedtype Element: Equatable
    associatedtype ContentView: View
    
    var items: FlowItem<Element> { get }
    var configuration: FlowConfiguration { get }
    var alignment: FlowAlignment { get }
}

public struct FlowItem<E: Equatable>: Equatable {
    var items: [E]
    
    public init(items: [E]) {
        self.items = items
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

public struct FlowLayoutModel<E: Equatable, ContentView: View>: FlowLayoutStyle {
    public typealias Element = E
    
    public var items: FlowItem<Element>
    public var configuration: FlowConfiguration
    public var alignment: FlowAlignment
    
    public init(items: FlowItem<Element>,
                configuration: FlowConfiguration = .zero,
                alignment: FlowAlignment = .leading) {
        self.items = items
        self.configuration = configuration
        self.alignment = alignment
    }
}
