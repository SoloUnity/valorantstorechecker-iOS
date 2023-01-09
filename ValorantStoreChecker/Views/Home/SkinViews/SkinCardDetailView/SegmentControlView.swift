//
//  SegmentControlView.swift
//  SegmentControl
//
//  Created by Pratik on 03/10/22.
//

import SwiftUI

struct SegmentControlView<ID: Identifiable, Content: View, Background: Shape>: View {
    let segments: [ID]
    @Binding var selected: ID
    var titleNormalColor: Color
    var titleSelectedColor: Color
    var bgColor: Color
    let animation: Animation
    @ViewBuilder var content: (ID) -> Content
    @ViewBuilder var background: () -> Background
    
    @Namespace private var namespace
    
    var body: some View {
        GeometryReader { bounds in
            HStack(spacing: 0) {
                ForEach(segments) { segment in
                    NewSegmentButtonView(id: segment,
                                         selectedId: $selected,
                                         titleNormalColor: titleNormalColor,
                                         titleSelectedColor: titleSelectedColor,
                                         bgColor: bgColor,
                                         animation: animation,
                                         namespace: namespace) {
                        content(segment)
                    } background: {
                        background()
                    }
                    .frame(width: bounds.size.width / CGFloat(segments.count))
                }
            }
            .background {
                background()
                    .fill(bgColor.opacity(0.1))
                    .overlay(
                        background()
                            .stroke(style: StrokeStyle(lineWidth: 1.5))
                            .foregroundColor(bgColor.opacity(0.2))
                    )
            }
        }
    }
}

fileprivate struct NewSegmentButtonView<ID: Identifiable, Content: View, Background: Shape> : View {
    let id: ID
    @Binding var selectedId: ID
    var titleNormalColor: Color
    var titleSelectedColor: Color
    var bgColor: Color
    var animation: Animation
    var namespace: Namespace.ID
    @ViewBuilder var content: () -> Content
    @ViewBuilder var background: () -> Background
    
    
    var body: some View {
        GeometryReader { bounds in
            Button {
                withAnimation(animation) {
                    selectedId = id
                }
            } label: {
                content()
            }
            .frame(width: bounds.size.width, height: bounds.size.height)
            .scaleEffect(selectedId.id == id.id ? 1 : 0.8)
            .clipShape(background())
            .foregroundColor(selectedId.id == id.id ? titleSelectedColor : titleNormalColor)
            .background(buttonBackground)
        }
    }
    
    @ViewBuilder private var buttonBackground: some View {
        if selectedId.id == id.id {
            background()
                .fill(bgColor)
                .matchedGeometryEffect(id: "SelectedTab", in: namespace)
        }
    }
}

enum Segment: Identifiable, CaseIterable {
    case morning, noon, evening
    
    var id: String {
        title
    }
    
    var title: String {
        switch self {
        case .morning:
            return "Morning"
        case .noon:
            return "Noon"
        case .evening:
            return "Evening"
        }
    }
    
    var icon: String {
        switch self {
        case .morning:
            return "sun.and.horizon.fill"
        case .noon:
            return "sun.max.fill"
        case .evening:
            return "moon.fill"
        }
    }
    
    var image: String {
        switch self {
        case .morning:
            return "Morning"
        case .noon:
            return "Day"
        case .evening:
            return "Evening"
        }
    }
}
