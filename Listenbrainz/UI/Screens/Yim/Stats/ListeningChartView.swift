//
//  ListeningChartView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct ListeningChartView: View {
    @ObservedObject var viewModel: YIMViewModel

    var body: some View {
        ZStack {
          Rectangle()
            .foregroundColor(.clear)
            .frame(height: UIScreen.main.bounds.height)
            .background(Color.yimGreen)

            VStack {
                TopYimView(viewModel: viewModel)
                .padding(.top)
              Spacer()

              if let maxCount = viewModel.mostListenedYear.values.max() {
                  Text("Most of the songs I listened to were from 2023 (\(maxCount))")
                  .font(
                  Font.custom("Roboto", size: 32)
                  .weight(.light)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.94, green: 0.93, blue: 0.89))

                  .frame(width: 324, alignment: .top)

              } else {
                  Text("")
              }


              Spacer()

                ScrollView(.horizontal) {
                    HStack(alignment: .center, spacing: 20) {
                        BarChartView(data: viewModel.mostListenedYear)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
                    }
                }
                .accentColor(.orange)

              Spacer()

                Text("MY STATS")
                .font(.system(size: 25, weight: .bold))
                .tracking(14)
                .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
                .padding()

              Image("share")
                  .frame(width: 49, height: 49)
                  .padding(.trailing,260)
                  .padding(.bottom,20)

             BottomYimView()
              Spacer()
            }
        }
//        .onAppear{
//          viewModel.fetchYIMData(userName: "Jasjeet")
//        }

    }
}

struct BarChartView: View {
    let data: [String: Int]

    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(data.sorted(by: { $0.key < $1.key }), id: \.key) { year, count in
                    VStack {
                        Rectangle()
                            .fill(Color.orange)
                            .border(Color.white, width: 1)
                            .frame(width: 15, height: barHeight(for: count))
                    }
                }
            }
            .padding(.bottom, 20)

            HStack {
                ForEach((1960...2000).filter { $0 % 5 == 0 }.map { "\($0)" }, id: \.self) { year in
                    Spacer()
                    Text(year)
                        .font(.caption)
                        .foregroundColor(.black)
                }
                Spacer()
            }
        }
    }

    private func barHeight(for count: Int) -> CGFloat {
        switch count {
        case 0...300:
          return CGFloat(count) / 2
        case 301...600:
          return CGFloat(count) / 2.5
        case 601...900:
          return CGFloat(count) / 3

        default:
          return CGFloat(count) / 8.5
        }
    }
}



struct ListeningChartView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return ListeningChartView(viewModel: viewModel)
    }
}

