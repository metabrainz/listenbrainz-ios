//
//  UserProfileView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/24.
//

import SwiftUI

struct UserProfileView: View {
    var user: User
    @EnvironmentObject var theme: Theme

    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 4)
            Text(user.userName)
                .font(.headline)
                .foregroundColor(theme.colorScheme.lbSignature)
            Spacer()
        }
        .padding()
    }
}
