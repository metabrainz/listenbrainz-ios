//
//  TopArtistsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct TopArtistsView: View {
    @StateObject var viewModel: YIMViewModel



    var body: some View {
        ZStack {
          Rectangle()
            .foregroundColor(.clear)
            .frame(height: UIScreen.main.bounds.height)
            .background(Color.yimGreen)

            VStack(alignment: .leading, spacing: 0) {


               TopYimView(viewModel: viewModel)

              Spacer()




                ForEach(Array(viewModel.topArtists.prefix(10).enumerated()), id: \.element.artistName) { index, artist in
                    HStack {
                        Text(index == 9 ? "X" : "\(index + 1)")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10)

                        Text(artist.artistName.uppercased())
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.leading,30)

                Spacer()

              Text("my top artists".uppercased())
                .font(.system(size: 25, weight: .bold))
                .tracking(14)
                .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
                .padding(.leading,80)
                .padding(.bottom,30)




              Image("share")
              .frame(width: 49, height: 49)
              .padding(.leading,30)
              .padding(.bottom,15)



              BottomYimView()
              
            }
            .padding()
        }
//        .onAppear{
//          viewModel.fetchYIMData(userName: "theflash_")
//        }
    }
}

struct TopArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return TopArtistsView(viewModel: viewModel)
    }
}




