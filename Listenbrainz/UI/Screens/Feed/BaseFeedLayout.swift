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
 *
 * - Parameters:
 *   - spacing: Spacing between all 4 elements of the layout.
 */
struct BaseFeedLayout: Layout {
    let spacing: CGFloat
    
    struct Cache {
        var iconSize: CGSize = .zero
        var originalTitleSize: CGSize = .zero
        var contentSize: CGSize = .zero
        var lineSize: CGSize = .zero
        
        var titleSize: CGSize {
            return CGSize(
                width: originalTitleSize.width,
                // Coerce title height with minimum of icon height.
                height: max(originalTitleSize.height, iconSize.height)
            )
        }
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
        
        let proposedTitleWidth: CGFloat? = if proposal.width == nil {
            nil
        }  else {
            proposal.width! - (cache.iconSize.width + spacing)
        }
        
        cache.originalTitleSize = subviews[1].sizeThatFits(
            ProposedViewSize(
                width: proposedTitleWidth,
                height: proposedTitleHeight
            )
        )
        
        let proposedContentHeight: CGFloat? = if proposal.height == nil {
            nil
        }  else {
            proposal.height! - (cache.titleSize.height + spacing)
        }
        
        let proposedContentWidth: CGFloat? = if proposal.width == nil {
            nil
        }  else {
            proposal.width! - (cache.iconSize.width + spacing)
        }
        
        cache.contentSize = subviews[2].sizeThatFits(
            ProposedViewSize(
                width: proposedContentWidth,
                height: proposedContentHeight
            )
        )
        
        cache.lineSize = subviews[3].sizeThatFits(
            ProposedViewSize(
                width: cache.iconSize.width,
                height: cache.titleSize.height + cache.contentSize.height + spacing - (cache.iconSize.height + spacing)
            )
        )
        
        return CGSize(
            width: proposal.width ?? cache.iconSize.width + max(cache.contentSize.width, cache.titleSize.width) + spacing,
            height: cache.titleSize.height + cache.contentSize.height + spacing
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        let top = bounds.minY
        let start = bounds.minX
        
        subviews[0].place(
            at: CGPoint(x: start, y: top),
            proposal: ProposedViewSize(cache.iconSize)
        )
        
        let titleOffsetFromTop = {
            if cache.iconSize.height > cache.originalTitleSize.height {
                return (cache.iconSize.height - cache.originalTitleSize.height) / 2
            } else {
                return 0
            }
        }()
        
        subviews[1].place(
            at: CGPoint(
                x: start + cache.iconSize.width + spacing,
                y: top + titleOffsetFromTop
            ),
            proposal: ProposedViewSize(cache.originalTitleSize)
        )
        
        subviews[2].place(
            at: CGPoint(
                x: start + cache.iconSize.width + spacing,
                y: top + cache.titleSize.height + spacing
            ),
            proposal: ProposedViewSize(cache.contentSize)
        )
        
        subviews[3].place(
            at: CGPoint(
                x: start,
                y: top + cache.iconSize.height + spacing
            ),
            proposal: ProposedViewSize(cache.lineSize)
        )
    }
}

struct BaseFeedView<Icon: View, Title: View, Content: View>: View {
    @ViewBuilder let icon: () -> Icon
    @ViewBuilder let title: () -> Title
    @ViewBuilder let content: () -> Content
    
    let lineColor: Color
    let spacing: CGFloat
    
    var body: some View {
        BaseFeedLayout(spacing: spacing) {
            ZStack(content: icon)
            
            ZStack(content: title)
            
            ZStack(content: content)
            
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
        lineColor: Color.white,
        spacing: 8,
    )
}
