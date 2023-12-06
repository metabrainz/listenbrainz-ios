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
      HStack(spacing:0){
        LBIcon2()
          .fill(Color.color_1)
        LBIcon1()
          .fill(Color.color_2)
      }
      .frame(width: 40, height: 40)

      Spacer()

      HStack(spacing: 0){
        Text("Listen")
          .foregroundColor(Color.color_2)

        Text("Brainz")
          .foregroundColor(Color.color_1)

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
          .foregroundColor(Color.color_1)

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
