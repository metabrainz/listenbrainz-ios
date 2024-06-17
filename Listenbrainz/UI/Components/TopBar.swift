//
//  TopBar.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 21/11/23.
//

import SwiftUI

struct TopBar: View {
    @Binding var isSettingsPressed: Bool
    @Binding var isSearchActive: Bool
    var customText: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            HStack(spacing: -13) {
                Image("secondaryIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Image("primaryIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }

            Text(customText)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.trailing, 20)

            Spacer()

            Button(action: {
                isSearchActive = true
            }) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing)
                    .foregroundColor(Color.primary)
            }

            Button(action: {
                isSettingsPressed.toggle()
            }) {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing)
                    .foregroundColor(Color.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.top, 70)
        .padding(.bottom, 20)
    }
}

#Preview{
        TopBar(isSettingsPressed: .constant(false), isSearchActive: .constant(false), customText: "Feed")
    }

