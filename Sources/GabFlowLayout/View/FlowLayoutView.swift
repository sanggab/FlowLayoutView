//
//  FlowLayoutView.swift
//  GabFlowLayout
//
//  Created by Gab on 2024/07/03.
//

import SwiftUI

public struct FlowLayoutView<Content: View>: View {
    @ViewBuilder private var content: () -> Content
    
    private var axis: Axis
    
    @ObservedObject private var viewModel: FlowLayoutViewModel = .init()
    @State private var frameSize: CGSize = .zero
    
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
                        .alignmentGuide(.leading) { d in
                            alignmentsSize = []
                            lineWidth = .zero
                            lineHeight = .zero
                            
                            return d[.leading]
                        }
                        .hidden()
                }
            }
            .frame(height: frameSize.height)
        }
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

                         let bounds: [CGRect] = value.map { proxy[$0] }
                         
                         let maxRect: CGRect? = bounds
                             .max {
                                 if $0.origin.y == $1.origin.y {
                                     return $0.height < $1.height
                                 } else {
                                     return $0.origin.y < $1.origin.y
                                 }
                             }
                         
                         if let maxRect {
                             if maxRect.origin.y + maxRect.height > proxy.size.height {
                                 if case .scroll = viewModel(\.layoutMode) {
                                     viewModel.action(.updIsOn(true))
                                 }
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
        if viewModel(\.isOn) {
            scrollVerticalView
        } else {
            nonScrollVerticalView
        }
    }
    
    @ViewBuilder
    var scrollVerticalView: some View {
        ScrollView(.horizontal, showsIndicators: viewModel(\.layoutMode).showIndicators) {
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
                            
                            if abs(lineHeight) + d.height > proxy.size.height {
                                
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
                        .alignmentGuide(.leading) { d in
                            
                            alignmentsSize = []
                            lineWidth = .zero
                            lineHeight = .zero
                            
                            return d[.leading]
                        }
                        .hidden()
                }
            }
            .frame(width: frameSize.width)
        }
    }
    
    @ViewBuilder
    var nonScrollVerticalView: some View {
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
                        
                        if abs(lineHeight) + d.height > proxy.size.height {
                            
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
            .background(setPreferenceSize())
        }
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        
                        let bounds: [CGRect] = value.map { proxy[$0] }

                        let maxRect: CGRect? = bounds
                            .max {
                                if $0.origin.x == $1.origin.x {
                                    return $0.width < $1.width
                                } else {
                                    return $0.origin.x < $1.origin.x
                                }
                            }
                        
                        if let maxRect {
                            if maxRect.origin.x + maxRect.width > proxy.size.width {
                                if case .scroll = viewModel(\.layoutMode) {
                                    viewModel.action(.updIsOn(true))
                                }
                            }
                        }
                        
                    }
            }
        }
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
        let view = self
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
