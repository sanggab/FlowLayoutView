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
    @StateObject private var viewModel: FlowLayoutViewModel<String> = .init()
    @ViewBuilder private var content: () -> Content
    
    private var axis: Axis
    
    public init(_ axis: Axis, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            content()
                .fixedSize()
                .alignmentGuide(.leading) { d in
                    switch axis {
                    case .horizontal:
                        print("horizontal")
                    case .vertical:
                        print("vertical")
                    }
                    
                    return d[.leading]
                }
                .onAppear {
                    viewModel.action(.updateIndex(1))
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
}

private extension FlowLayoutView {
    
    func calLeadingHorizontal(d: ViewDimensions, proxy: GeometryProxy) -> CGFloat {
        let currentLineWidth: CGFloat = viewModel(\.currentLineWidth)
        print("width : \(d.width)")
        print("currentLineWidth : \(currentLineWidth)")
        print("view Size: \(proxy.size)")
        
        if currentLineWidth + d.width > proxy.size.width {
            print("다음줄로 넘어가야됨")
            return d.width
        } else {
            print("그냥 붙히자")
//            viewModel.action(.updateCurrentLineWidth(d.width))
            
            return currentLineWidth + d.width
        }
        
        
    }
}

