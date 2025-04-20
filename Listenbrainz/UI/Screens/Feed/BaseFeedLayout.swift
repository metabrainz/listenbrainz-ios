//
//  MyCustomLayout.swift
//  Listenbrainz
//
//  Created by Jasjeet Singh on 20/04/25.
//

import SwiftUI

/** Layout used to dynamically constrain size of the line in feed view.
 *
 * This will be a 4 item grid layout where number of subviews must be exactly 4.
 * Subviews will be processed in the following order: Top-left (icon) -> top-right  (tagline)-> bottom-right (main content) -> bottom-left (essentially our dynamic line)
 */
struct BaseFeedLayout: Layout {
    struct Cache {
        var iconSize: CGSize = .zero
        var titleSize: CGSize = .zero
        var contentSize: CGSize = .zero
        var lineSize: CGSize = .zero
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        return Cache()
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        if subviews.count != 4 {
            print("BaseFeedLayout requires exactly 4 subviews but \(subviews.count) were provided")
            return .zero
        }
        
        cache.iconSize = subviews[0].sizeThatFits(proposal)
        
        let proposedTitleHeight: CGFloat? = if proposal.height == nil {
            nil
        }  else {
            max(proposal.height!, cache.iconSize.height)
        }
        
        cache.titleSize = subviews[1].sizeThatFits(
            ProposedViewSize(
                width: proposal.width! - cache.iconSize.width,
                height: proposedTitleHeight
            )
        )
        
        // Coerce title height with minimum of icon height.
        cache.titleSize.height = max(cache.titleSize.height, cache.iconSize.height)
        
        let proposedContentHeight: CGFloat? = if proposal.height == nil {
            nil
        }  else {
            proposal.height! - cache.iconSize.height
        }
        
        cache.contentSize = subviews[2].sizeThatFits(
            ProposedViewSize(
                width: proposal.width! - cache.iconSize.width,
                height: proposedContentHeight
            )
        )
        
        cache.lineSize = subviews[3].sizeThatFits(
            ProposedViewSize(
                width: cache.iconSize.width,
                height: cache.titleSize.height + cache.contentSize.height - cache.iconSize.height
            )
        )
        
        return CGSize(
            width: proposal.width ?? cache.iconSize.width + max(cache.contentSize.width, cache.titleSize.width),
            height: cache.titleSize.height + cache.contentSize.height
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        let top = bounds.minY
        let start = bounds.minX
        
        subviews[0].place(
            at: CGPoint(x: start, y: top),
            proposal: ProposedViewSize(cache.iconSize)
        )
        
        subviews[1].place(
            at: CGPoint(x: start + cache.iconSize.width, y: top),
            proposal: ProposedViewSize(cache.titleSize)
        )
        
        subviews[2].place(
            at: CGPoint(x: start + cache.iconSize.width, y: top + cache.titleSize.height),
            proposal: ProposedViewSize(cache.contentSize)
        )
        
        subviews[3].place(
            at: CGPoint(x: start, y: top + cache.iconSize.height),
            proposal: ProposedViewSize(cache.lineSize)
        )
    }
}

struct BaseFeedView<Icon: View, Title: View, Content: View>: View {
    @ViewBuilder let icon: () -> Icon
    @ViewBuilder let title: () -> Title
    @ViewBuilder let content: () -> Content
    
    let lineColor: Color
    let spacing: CGFloat = 8
    
    var body: some View {
        BaseFeedLayout {
            icon()
                .padding(.bottom, spacing)
            
            title()
                .padding(.leading, spacing)
            
            content()
                .padding(.leading, spacing)
            
            ZStack(alignment: .center) {
                VerticalLine(color: lineColor)
                    .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    }
}


#Preview {
    BaseFeedView(
        icon: {
            Image("caa_logo")
                .resizable()
                .frame(width: 24, height: 24)
        },
        title: {
            Text("Title")
        },
        content: {
            ZStack {}
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
        },
        lineColor: Color.white
    )
}
