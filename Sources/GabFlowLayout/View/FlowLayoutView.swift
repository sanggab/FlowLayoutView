//
//  FlowLayoutView.swift
//  GabFlowLayout
//
//  Created by Gab on 2024/07/03.
//

import SwiftUI

struct CGSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize,
                       nextValue: () -> CGSize) {
        value = nextValue()
    }
}

public struct FlowLayoutView<Content: View>: View {
    @ViewBuilder private var content: () -> Content
    @State private var frameSize: CGSize = .zero
    
    private var axis: Axis
    
    private var configuration: FlowConfiguration = .zero
    
    public init(_ axis: Axis,
                @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }
    
    public var body: some View {
        if axis == .horizontal {
            horizontalView
        } else {
            verticalView
        }
    }
}

private extension FlowLayoutView {
    
    @ViewBuilder
    var horizontalView: some View {
        ZStack(alignment: .topLeading) {
            
            var lineWidth: CGFloat = .zero
            var lineHeight: CGFloat = .zero
            var alignmentsSize: [CGSize] = []
            
            content()
                .alignmentGuide(.leading) { d in
                    var result: CGFloat = .zero
                    
                    if abs(lineWidth) + d.width > frameSize.width {
                        
                        let height: CGFloat = (alignmentsSize
                                            .map{ $0.height }
                                            .max() ?? d.height) + configuration.lineSpacing
                        
                        lineHeight = height
                        lineWidth = .zero
                        result = d[.leading]
                    } else {
                        
                        result = lineWidth
                    }
                    
                    let width: CGFloat = d.width + configuration.itemSpacing
                    lineWidth -= width
                    
                    alignmentsSize.append(CGSize(width: width, height: lineHeight + d.height))

                    return result
                }
                .alignmentGuide(.top) { d in
                    return -lineHeight
                }
            
            Color.clear
                .frame(width: .zero, height: .zero)
                .alignmentGuide(.leading, computeValue: { dimension in
                    
                    alignmentsSize = []
                    lineWidth = .zero
                    lineHeight = .zero
                    
                    return dimension[.leading]
                })
                .hidden()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(setPreferenceSize())
    }
}

private extension FlowLayoutView {
    
    @ViewBuilder
    var verticalView: some View {
        ZStack(alignment: .topLeading) {
            
            var lineWidth: CGFloat = .zero
            var lineHeight: CGFloat = .zero
            var alignmentsSize: [CGSize] = []
            
            content()
                .alignmentGuide(.leading) { d in
                    var result: CGFloat = .zero
                    
                    if abs(lineHeight) + d.height > frameSize.height {
                        
                        let width: CGFloat = (alignmentsSize
                                            .map{ $0.width }
                                            .max() ?? d.width) + configuration.itemSpacing
                        
                        lineHeight = .zero
                        lineWidth = -width
                        result = lineWidth
                    } else {
                        result = lineWidth
                    }
                    
                    
                    let height: CGFloat = d.height + configuration.lineSpacing
                    let width: CGFloat = d.width
                    alignmentsSize.append(CGSize(width: abs(lineWidth) + width, height: height))
                    
                    return result
                }
                .alignmentGuide(.top) { d in
                    var result: CGFloat = .zero
                    
                    result -= lineHeight
                    
                    let height: CGFloat = d.height + configuration.lineSpacing
                    
                    lineHeight += height
                    
                    return result
                }
            
            Color.clear
                .frame(width: .zero, height: .zero)
                .alignmentGuide(.leading, computeValue: { dimension in
                    
                    alignmentsSize = []
                    lineWidth = .zero
                    lineHeight = .zero
                    
                    return dimension[.leading]
                })
                .hidden()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(setPreferenceSize())
    }
}

private extension FlowLayoutView {
    
    func setPreferenceSize() -> some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    frameSize = proxy.size
                }
        }
    }
}

public extension FlowLayoutView {
    
    func configurationSpacing(line: CGFloat = .zero, item: CGFloat = .zero) -> FlowLayoutView {
        var view = self
        view.configuration = FlowConfiguration(lineSpacing: line,
                                               itemSpacing: item)
        return view
    }
}
