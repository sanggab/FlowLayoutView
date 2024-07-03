//
//  FlowLayoutView.swift
//  GabFlowLayout
//
//  Created by Gab on 2024/07/03.
//

import SwiftUI

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

public struct FlowLayoutView<Content: View>: View {
//    @StateObject private var viewModel: FlowLayoutViewModel<String> = .init()
    @ViewBuilder private var content: () -> Content
    
    private var axis: Axis
    
    public init(_ axis: Axis, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { proxy in
            var currentLineWidth: CGFloat = .zero
            var maxHeight: CGFloat = .zero
            
            
            ZStack(alignment: .topLeading) {
                content()
                    .alignmentGuide(.leading) { d in
                        switch axis {
                        case .horizontal:
                            print("horizontal")
                            
                            if currentLineWidth + d.width > proxy.size.width {
                                print("넘엉")
                            } else {
                                print("안넘엉")
                            }
                            
                        case .vertical:
                            print("vertical")
                        }
                        
                        return d[.leading]
                    }
                
                Color.clear
                    .frame(width: .zero, height: .zero)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        print("hoho")
                        
                        return dimension[.leading]
                    })
                    .hidden()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
