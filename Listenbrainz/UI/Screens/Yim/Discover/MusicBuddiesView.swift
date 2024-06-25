//
//  MusicBuddiesView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//


import SwiftUI

struct MusicBuddiesView: View {
  @StateObject var viewModel: YIMViewModel
  @State private var similarityPercentage: Double = 0.0

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.clear)
        .frame(height: UIScreen.main.bounds.height)
        .background(Color.yimGreen)

      VStack(alignment: .leading, spacing: 10) {
        TopYimView(viewModel: viewModel)
          .padding(.top, 30)

        Spacer()

        GeometryReader { geometry in
          List {
            ForEach(viewModel.similarUsers.sorted(by: { $0.value > $1.value }), id: \.key) { userId, similarity in
              HStack {
                VStack(alignment: .leading, spacing: 5) {
                  Text(userId)
                    .font(.system(size: 16, weight: .bold))


                  HStack(spacing: 8) {
                    //                            ProgressBar(value: Binding<Double>(
                    //                              get: { Double(viewModel.similarity) },
                    //                              set: { viewModel.similarity = Float($0) }
                    //                            ), maxValue: 1.0)
                    //                            .frame(width: 100, height: 10)
                    Text("\(String(format: "%.2f", similarity * 100))")
                      .font(.system(size: 16))
                  }
                }
              }
            }
          }
          .listStyle(PlainListStyle())
          .listRowSeparator(.hidden)
          .frame(width: 350)
          .position(x: geometry.size.width / 2, y: geometry.size.height / 2.2)
        }


        VStack(spacing: -70) {
          Text("my music buddies".uppercased())
            .font(.system(size: 25, weight: .bold))
            .tracking(14)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
            .frame(width: 380, height: 200, alignment: .top)

          Image("share")
            .frame(width: 49, height: 49)
            .padding(.trailing, 250)
        }

        BottomYimView()
          .padding(.bottom, 30)



          .padding()

      }
      .padding()
    }
    .onAppear {
//      viewModel.fetchYIMData(userName: "theflash_")

      similarityPercentage = viewModel.similarUsers["someUserId"] ?? 0.0
    }
  }
}

#Preview{
    let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
    return MusicBuddiesView(viewModel: viewModel)
  }


//struct ProgressBar: View {
//  @Binding var value: Double
//  let maxValue: Double
//
//  var body: some View {
//    GeometryReader { geometry in
//      ZStack(alignment: .leading) {
//        Rectangle()
//          .foregroundColor(Color.gray.opacity(0.3))
//          .frame(width: geometry.size.width, height: 10)
//
//        Rectangle()
//          .foregroundColor(Color.blue)
//          .frame(width: min(CGFloat(value / maxValue) * geometry.size.width, geometry.size.width), height: 10)
//      }
//    }
//  }
//}


