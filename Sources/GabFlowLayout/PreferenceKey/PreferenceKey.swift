//
//  PreferenceKey.swift
//  GabFlowLayout
//
//  Created by Gab on 2024/07/10.
//

import SwiftUI

struct CGSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize,
                       nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct BoundsPreferenceKey: PreferenceKey {
    typealias Bounds = Anchor<CGRect>
    static var defaultValue = [Bounds]()

    static func reduce(
        value: inout [Bounds],
        nextValue: () -> [Bounds]
    ) {
        value.append(contentsOf: nextValue())
    }
}

struct CGPointPreferenceKey: PreferenceKey {
    typealias Points = Anchor<CGPoint>
    static var defaultValue = [Points]()

    static func reduce(
        value: inout [Points],
        nextValue: () -> [Points]
    ) {
        value.append(contentsOf: nextValue())
    }
}
