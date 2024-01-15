//
//  BottomYimView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct BottomYimView: View{


  var body: some View{

    HStack{
      Spacer()
      Text(" #YEARINMUSIC")
        .font(Font.custom("Inter", size: 16).weight(.bold))
        .italic()
        .foregroundColor(Color.yimBeige)
      Spacer()
      Spacer()
        Image("downArrow")
            .frame(width: 24, height: 24)
      Spacer()
      Spacer()

      Text("LISTENBRAINZ ")
        .font(Font.custom("Inter", size: 16).weight(.bold))
        .foregroundColor(Color.yimBeige)
      Spacer()
    }
    .padding(.bottom,20)
  }
}


