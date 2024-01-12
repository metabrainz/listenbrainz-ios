//
//  TopAlbumsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct TopAlbumsView: View {
    @ObservedObject var viewModel: YIMViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: UIScreen.main.bounds.height)
                .background(Color.yimGreen)

          VStack(alignment:.leading) {
            Spacer()
                TopYimView(viewModel: viewModel)
              .padding(.top,-10)

                Spacer()
            Spacer()

                ForEach(viewModel.topReleaseGroups.prefix(5), id: \.self) { topReleaseGroup in
                    Text(topReleaseGroup.releaseGroupName.uppercased())
                        .font(
                            Font.custom("Inter", size: 36)
                                .weight(.bold)
                        )
                        .foregroundColor(Color.yimBeige)
                        .padding(.leading,40)
                }

                Spacer()

                Text("my top albums".uppercased())
              .font(.system(size: 25, weight: .bold))
              .tracking(14)
              .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
              .padding(.leading,90)

                Image("share")
                    .resizable()
                    .frame(width: 49, height: 49)
                    .padding(.leading,40)
                    .padding(.bottom, 40)

                BottomYimView()

                Spacer()
            }
//            .onAppear {
//                viewModel.fetchYIMData(userName: "akshaaatt")
//            }
        }
    }
}


struct TopAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return TopAlbumsView(viewModel: viewModel)
    }
}

