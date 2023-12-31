//
//  TopBar.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 21/11/23.
//

import SwiftUI

struct TopBar: View {
  @Binding var isSettingsPressed: Bool

  var body: some View {
    HStack {

      HStack(spacing:-18){
        Image("secondaryIcon")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
        Image("primaryIcon")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
      }



      Spacer()

      HStack(spacing: 0){
        Text("Listen")
          .foregroundColor(Color.secondary)

        Text("Brainz")
          .foregroundColor(Color.primary)

      }

        .font(.largeTitle)
        .fontWeight(.bold)

      Spacer()

      Button(action: {
        isSettingsPressed.toggle()
      }) {
        Image(systemName: "gear")
          .resizable()
          .frame(width: 30, height: 30)
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



struct TopBar_Previews: PreviewProvider {
  static var previews: some View {
    TopBar(isSettingsPressed: .constant(false))

  }
}
