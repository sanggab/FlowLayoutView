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

struct CGSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize,
                       nextValue: () -> CGSize) {
        value = nextValue()
    }
}

public struct FlowLayoutView<Content: View>: View {
//    @StateObject private var viewModel: FlowLayoutViewModel<String> = .init()
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
        ZStack(alignment: .topLeading) {
            
            var lineWidth: CGFloat = .zero
            var lineHeight: CGFloat = .zero
            var alignmentsSize: [CGSize] = []
            
            content()
                .alignmentGuide(.leading) { d in
                    
                    var result: CGFloat = .zero
                    
//                    print("frameSize: \(frameSize)")
                    
                    switch axis {
                    case .horizontal:
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
                        
                    case .vertical:
                        
                        if abs(lineHeight) + d.height > frameSize.height {
                            print("alignmentsSize: \(alignmentsSize)")
                            let width: CGFloat = (alignmentsSize
                                                .map{ $0.width }
                                                .max() ?? d.width) + configuration.itemSpacing
                            print("lineWidth: \(lineWidth)")
                            print("width: \(width)")
                            
                            lineHeight = .zero
                            lineWidth = -width
                            result = lineWidth
                        } else {
                            result = lineWidth
                        }
                        
                        
                        let height: CGFloat = d.height + configuration.lineSpacing
                        let width: CGFloat = d.width
                        alignmentsSize.append(CGSize(width: abs(lineWidth) + width, height: height))
                        
                    }
                    
                    return result
                }
                .alignmentGuide(.top) { d in
                    
                    switch axis {
                    case .horizontal:
                        
                        return -lineHeight
                        
                    case .vertical:
                        var result: CGFloat = .zero
                        
                        result -= lineHeight
                        
                        let height: CGFloat = d.height + configuration.lineSpacing
                        
                        lineHeight += height
                        
                        return result
                    }
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
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        .background(Color.pink)
        .background(setPreferenceSize())
    }
    
    private func setPreferenceSize() -> some View {
        GeometryReader { proxy in
//            Color.clear
//                .preference(key: CGSizePreferenceKey.self, value: proxy.size)
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
