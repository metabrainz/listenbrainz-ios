//
//  CapsuleBarView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import SwiftUI

struct CapsuleBarView: View {
    var title: String
    var isSelected: Bool
    var imageName: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .colorMultiply(.white)
            Text(title)
                .font(.headline)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(isSelected ? Capsule().fill(Color.secondary) : Capsule().fill(Color.gray))
        .foregroundColor(.white)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
