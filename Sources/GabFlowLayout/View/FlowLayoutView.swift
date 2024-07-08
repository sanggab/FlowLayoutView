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

struct CGPointPreferenceKey: PreferenceKey {
    typealias Bounds = Anchor<CGPoint>
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
                .anchorPreference(key: CGPointPreferenceKey.self, value: .topLeading) { anchor in
                    [anchor]
                }
                .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                    [anchor]
                }
                .alignmentGuide(.leading) { d in
                    var result: CGFloat = .zero

                    print("frameSize: \(frameSize)")
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
        .backgroundPreferenceValue(CGPointPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        let values: [CGPoint] = value.map {
                            print("horizontal point : \(proxy[$0])")
                            return proxy[$0]
                        }
                    }
            }
        }
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        print("proxy : \(proxy.frame(in: .global).size)")
                        let values: [CGRect] = value.map {
                            print("horizontal bounds : \(proxy[$0])")
                            return proxy[$0]
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
                .anchorPreference(key: CGPointPreferenceKey.self, value: .topLeading) { anchor in
                    [anchor]
                }
                .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                    [anchor]
                }
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
        .backgroundPreferenceValue(CGPointPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        frameSize = proxy.size
                        let values: [CGPoint] = value.map {
                            print("vertical point : \(proxy[$0])")
                            return proxy[$0]
                        }
                    }
            }
        }
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        let values: [CGRect] = value.map {
                            print("vertical bounds : \(proxy[$0])")
                            return proxy[$0]
                        }
                    }
            }
        }
    }
    
    private func setPreferenceSize() -> some View {
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
