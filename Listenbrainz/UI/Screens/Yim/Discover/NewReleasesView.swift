//
//  NewReleasesView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct NewReleasesView: View {
  @StateObject var viewModel: YIMViewModel
  var body: some View {
      ZStack {
        Rectangle()
        .foregroundColor(.clear)
        .frame(height: UIScreen.main.bounds.height)
        .background(Color.yimGreen)

          VStack(alignment: .leading, spacing: 10) {


              TopYimView(viewModel: viewModel)





            VStack {
              GeometryReader { geometry in
                  List {
                      ForEach(Array(viewModel.newReleasesOfTopArtist.enumerated()), id: \.element.title) { index, release in
                          HStack {
                            Image(systemName: "music.note")
                              .resizable()
                              .renderingMode(.template)
                              .foregroundColor(.orange)
                              .scaledToFit()
                              .frame(height: 22)
                              .padding(4)

                              VStack(alignment: .leading, spacing: 5) {
                                  Text(release.title)
                                      .font(.system(size: 16, weight: .bold))

                                  Text(release.artistCreditName)
                                      .font(.system(size: 16))
                              }
                          }
                      }
                  }
                  .frame(width: 350,height: 300)
                  .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                  .listStyle(PlainListStyle())
                  .listRowSeparator(.hidden)

              }
            }
            

            VStack(spacing:-40){

              Text("new albums from my top artists".uppercased())
                .font(.system(size: 25, weight: .bold))
                .tracking(14)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
                .frame(width: 380, height: 200, alignment: .top)

              Image("share")
                .frame(width: 49, height: 49)
                .padding(.trailing,250)
            }


              BottomYimView()
              .padding(.bottom,30)

          }
          .padding()
      }

//      .onAppear{
//        viewModel.fetchYIMData(userName: "theflash_")
//      }

  }
}


#Preview{
  let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
  return NewReleasesView(viewModel: viewModel)
}


