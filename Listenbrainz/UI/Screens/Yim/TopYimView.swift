//
//  TopYimView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct TopYimView: View {

  @ObservedObject var viewModel: YIMViewModel

   init(viewModel: YIMViewModel) {
       self.viewModel = viewModel
   }


    var body: some View {

      VStack{

        HStack {
          Spacer()

          Text(  viewModel.userName.uppercased())
            .font(
              Font.custom("Inter", size: 16)
                .weight(.bold)
            )
            .foregroundColor(Color.yimBeige)


          Spacer()
          Spacer()

          Image("upArrow")


          Spacer()
          Spacer()

          Text("2023 ")
            .font(
              Font.custom("Inter", size: 16)
                .weight(.bold)
            )
            .foregroundColor(Color.yimBeige)
          Spacer()

        }
        .padding(.top,20)


        Text("my year in music".uppercased())
          .font(.system(size: 22, weight: .bold))
          .tracking(15)
          .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
          .padding(.top,20)


      }
    }
}

