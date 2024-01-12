//
//  PlaylistTitleView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/01/24.
//

import SwiftUI

struct PlaylistsTitleView: View{
  @ObservedObject var viewModel: YIMViewModel

   init(viewModel: YIMViewModel) {
       self.viewModel = viewModel
   }

  var body: some View{


      ZStack {
        Rectangle()
          .foregroundColor(.clear)
          .frame(height: UIScreen.main.bounds.height)
          .background(Color.yimGreen)
        VStack{
          TopYimView(viewModel: viewModel)
            .padding(.top,35)

          Spacer()
          Spacer()
          Spacer()

          Text("PLAYLISTS")
            .font(.system(size: 32, weight: .bold))
            .tracking(17.27)
            .foregroundColor(Color(red: 0.94, green: 0.93, blue: 0.89))
          Spacer()
          Spacer()

            Image("share")
                .frame(width: 49, height: 49)
          Spacer()


          Text(viewModel.userName.uppercased())
            .font(.system(size: 25, weight: .bold))   .tracking(14)
            .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
          Spacer()

          BottomYimView()

          Spacer()


        }
      }
//      .onAppear{
//        viewModel.fetchYIMData(userName: "theflash_")
//      }
    }

  }


struct PlaylistsTitleView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return PlaylistsTitleView(viewModel: viewModel)
    }
}

