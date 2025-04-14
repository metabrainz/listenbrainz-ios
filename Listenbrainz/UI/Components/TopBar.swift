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
    @EnvironmentObject var theme: Theme

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
                .foregroundColor(theme.colorScheme.text)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.trailing, 20)
            
            Spacer()
            
            Button(action: {
                isSearchActive.toggle()
            }) {
                Image("search")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .padding(.trailing)
                    .foregroundColor(theme.colorScheme.text.opacity(0.7))
            }
            
            Button(action: {
                isSettingsPressed.toggle()
            }) {
                Image("settings")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 16)
                    .foregroundColor(theme.colorScheme.text.opacity(0.7))
            }
        }
        .fullScreenCover(isPresented: $isSearchActive) {
            SearchUsersView(isSearchActive: $isSearchActive)
                .edgesIgnoringSafeArea(.all)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, theme.spacings.horizontal)
        .padding(.top, 70)
        .padding(.bottom)
    }
}

#Preview{
        TopBar(isSettingsPressed: .constant(false), isSearchActive: .constant(false), customText: "Feed")
    }

