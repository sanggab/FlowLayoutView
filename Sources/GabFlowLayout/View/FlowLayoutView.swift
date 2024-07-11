//
//  FlowLayoutView.swift
//  GabFlowLayout
//
//  Created by Gab on 2024/07/03.
//

import SwiftUI

public struct FlowLayoutView<Content: View>: View {
    @ViewBuilder private var content: () -> Content
    @State private var frameSize: CGSize = .zero
    
    private var axis: Axis
    
    @ObservedObject private var viewModel: FlowLayoutViewModel = .init()
    
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
        if viewModel(\.isOn) {
            scrollHorizontalView
        } else {
            nonScrollHorizontalView
        }
    }
    
    
    @ViewBuilder
    var scrollHorizontalView: some View {
        ScrollView(.vertical, showsIndicators: viewModel(\.layoutMode).showIndicators) {
            GeometryReader { proxy in
                let _ = print("proxy22 : \(proxy.size)")
                ZStack(alignment: .topLeading) {
                    
                    var lineWidth: CGFloat = .zero
                    var lineHeight: CGFloat = .zero
                    var alignmentsSize: [CGSize] = []
                    
                    content()
                        .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                            [anchor]
                        }
                        .alignmentGuide(.leading) { d in
                            var result: CGFloat = .zero
                            if abs(lineWidth) + d.width > proxy.size.width {
                                
                                let height: CGFloat = (alignmentsSize
                                    .map{ $0.height }
                                    .max() ?? d.height) + viewModel(\.configuration).lineSpacing
                                
                                lineHeight = height
                                lineWidth = .zero
                                result = d[.leading]
                            } else {
                                
                                result = lineWidth
                            }
                            
                            let width: CGFloat = d.width + viewModel(\.configuration).itemSpacing
                            lineWidth -= width
                            
                            alignmentsSize.append(CGSize(width: width, height: lineHeight + d.height))
                            
                            return result
                        }
                        .alignmentGuide(.top) { d in
        //                        if lineHeight + d.height <= proxy.size.height {
        //                            return -lineHeight
        //                        } else {
        //                            return 0
        //                        }
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
//                .background(setPreferenceSize())
            }
            .frame(height: frameSize.height)
        }
//        .background(Color.black.opacity(0.7))
    }
    
    @ViewBuilder
    var nonScrollHorizontalView: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                
                var lineWidth: CGFloat = .zero
                var lineHeight: CGFloat = .zero
                var alignmentsSize: [CGSize] = []
                
                content()
                    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                        [anchor]
                    }
                    .alignmentGuide(.leading) { d in
                        var result: CGFloat = .zero
                        
                        if abs(lineWidth) + d.width > proxy.size.width {
                            
                            let height: CGFloat = (alignmentsSize
                                .map{ $0.height }
                                .max() ?? d.height) + viewModel(\.configuration).lineSpacing
                            
                            lineHeight = height
                            lineWidth = .zero
                            result = d[.leading]
                        } else {
                            
                            result = lineWidth
                        }
                        
                        let width: CGFloat = d.width + viewModel(\.configuration).itemSpacing
                        lineWidth -= width
                        
                        alignmentsSize.append(CGSize(width: width, height: lineHeight + d.height))
                        
                        return result
                    }
                    .alignmentGuide(.top) { d in
//                        if lineHeight + d.height <= proxy.size.height {
//                            return -lineHeight
//                        } else {
//                            return 0
//                        }
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
            .background(setPreferenceSize())
        }
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
             GeometryReader { proxy in
                 Color.clear
                     .onAppear {
                         print("proxy : \(proxy.size)")
                         let bounds: [CGRect] = value.map {
                             print("bound : \(proxy[$0])")
                             return proxy[$0]
                         }
                         
                         let max = bounds
                                        .sorted(by: { $0.maxY >= $1.maxY})
                                        .sorted(by: { $0.height > $1.height })
                                        .first
                         
                         print("max : \(max)")
                         
                         if let max {
                             if max.origin.y + max.height > proxy.size.height {
                                 print("사이즈가 넘어버림")
                                 if case .scroll = viewModel(\.layoutMode) {
//                                     isOn = true
                                     viewModel.action(.updIsOn(true))
                                 }
                             } else {
                                 print("사이즈가 안넘어버림")
                             }
                         }
                     }
             }
         }
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
                            .max() ?? d.width) + viewModel(\.configuration).lineSpacing
                        
                        lineHeight = .zero
                        lineWidth = -width
                        result = lineWidth
                    } else {
                        result = lineWidth
                    }
                    
                    
                    let height: CGFloat = d.height + viewModel(\.configuration).itemSpacing
                    let width: CGFloat = d.width
                    alignmentsSize.append(CGSize(width: abs(lineWidth) + width, height: height))
                    
                    return result
                }
                .alignmentGuide(.top) { d in
                    var result: CGFloat = .zero
                    
                    result -= lineHeight
                    
                    let height: CGFloat = d.height + viewModel(\.configuration).itemSpacing
                    
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
                    print("frameSize: \(frameSize)")
                }
        }
    }
}

public extension FlowLayoutView {
    
    func configurationSpacing(line: CGFloat = .zero, item: CGFloat = .zero) -> FlowLayoutView {
        let view = self
//        view.configuration = FlowConfiguration(lineSpacing: line,
//                                               itemSpacing: item)
        view.viewModel.action(.updConfiguration(FlowConfiguration(lineSpacing: line,
                                                                   itemSpacing: item)))
        return view
    }
    
    func layoutMode(_ mode: FlowLayoutMode) -> FlowLayoutView {
        let view = self
        view.viewModel.action(.updLayoutMode(mode))
        return view
    }
}
