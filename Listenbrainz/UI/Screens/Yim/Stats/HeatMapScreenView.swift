//
//  HeatMapScreenView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct HeatMapScreenView: View {
    @ObservedObject var viewModel = YIMViewModel(repository: YIMRepositoryImpl())

    var body: some View {
      ZStack {
        Rectangle()
          .foregroundColor(.clear)
          .frame(height: UIScreen.main.bounds.height)
          .background(Color.yimGreen)

        VStack() {
          Spacer()
            TopYimView(viewModel: viewModel)
            .padding(.top,35)

        Spacer()


          Text("I listened to the most music in June (\(String(viewModel.totalListenCount)) songs)")
            .font(
              Font.custom("Roboto", size: 32)
                .weight(.light)
            )
            .multilineTextAlignment(.center)
            .foregroundColor(Color.yimBeige)
            .frame(width: 285, alignment: .top)

          Spacer()



            if !viewModel.listensPerDay.isEmpty {
                HeatMapView(listensPerDay: viewModel.listensPerDay)
                    .frame(height: 200)
            } else {
                Text("Loading...")
            }

          Spacer()




          Text("my stats".uppercased())
            .font(.system(size: 25, weight: .bold))
            .tracking(14)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
            .frame(width: 252, height: 20, alignment: .top)

          Spacer()

          Image("share")
              .frame(width: 49, height: 49)
              .padding(.trailing,260)
              .padding(.bottom,20)


           BottomYimView()
            .padding(.bottom,35)
          Spacer()
          }
      }
//      .onAppear{
//        viewModel.fetchYIMData(userName: "akshaaatt")
//      }
        .foregroundColor(.white)
        .ignoresSafeArea()

    }
}

struct HeatMapView: View {
    let listensPerDay: [ListensPerDay]

    var body: some View {
      ScrollView(.horizontal) {

          // Display your heat map here using listensPerDay data
        LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 7), spacing: 1) {
            ForEach(listensPerDay, id: \.timeRange) { listenData in
              Rectangle()
                .fill(heatMapColor(for: listenData.listenCount))
                .frame(width: 18, height: 18)
            }
          }
        }

        .padding()
        .background(RoundedRectangle(cornerRadius: 10))
    }

    private func heatMapColor(for listenCount: Int) -> Color {
       
        switch listenCount {
        case 0..<35:
            return Color(red: 0.93, green: 0.92, blue: 0.94)
        case 35..<50:
            return Color(red: 0.84, green: 0.61, blue: 0.49)
        case 50..<75:
            return Color(red: 0.74, green: 0.71, blue: 0.89)
        case 75..<100:
            return Color(red: 0.20, green: 0.18, blue: 0.49)
        default:
            return Color(red: 0.89, green: 0.45, blue: 0.24)
        }
    }
}



struct HeatMapScreenView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = YIMViewModel(repository: YIMRepositoryImpl()) // Assuming you have a default initializer for your YIMViewModel
        return HeatMapScreenView(viewModel: viewModel)
    }
}

