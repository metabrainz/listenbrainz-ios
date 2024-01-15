//
//  TopRecordingsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct TopRecordingsView: View {
  @ObservedObject var viewModel: YIMViewModel


    var body: some View {
      ZStack {
        Rectangle()
          .foregroundColor(.clear)
          .frame(height: UIScreen.main.bounds.height)
          .background(Color.yimGreen)




          VStack(alignment: .leading, spacing: -2) {
              TopYimView(viewModel: viewModel)
              .padding(.top,-30)

            Spacer()



              ForEach(Array(viewModel.topRecordings.prefix(10).enumerated()), id: \.element.trackName) { index, recording in
                  HStack {
                      Text(index == 9 ? "X" : "\(index + 1)")
                          .font(.system(size: 16, weight: .bold))
                          .foregroundColor(Color.yimBeige)
                          .padding(.trailing, 10)

                      VStack(alignment: .leading, spacing: 0) {
                          Text(recording.trackName.uppercased())
                              .font(.system(size: 16, weight: .bold))
                              .foregroundColor(Color.white)

                          Text(recording.artistName.uppercased())
                          .font(.system(size: 16))
                              .foregroundColor(Color.white)
                      }
                  }
              }
              .padding(.leading,30)


           Spacer()
              Text("MY TOP SONGS")
              .font(.system(size: 25, weight: .bold))
              .tracking(14)
                  .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
                  .padding(.leading,80)


            Image("share")
            .frame(width: 49, height: 49)
            .padding(.leading)
            .padding(.bottom,15)


             BottomYimView()
          }
          .padding()
      }
//      .onAppear{
//        viewModel.fetchYIMData(userName: "theflash_")
//      }
  }
}

struct TopRecordingsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return TopRecordingsView(viewModel: viewModel)
    }
}

