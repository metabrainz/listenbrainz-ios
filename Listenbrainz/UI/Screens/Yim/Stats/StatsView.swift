//
//  StatsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct StatsView: View{
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

          HStack{

            VStack{

              Text("Red")
                .font(Font.custom("Roboto", size: 32).weight(.bold))
                .foregroundColor(Color.yimBeige)

              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 52, height: 1)
                .overlay(
                  Rectangle()
                    .stroke(Color(red: 0.94, green: 0.93, blue: 0.89), lineWidth: 0.50)

                )

              Text("was my cover art color")
                .font(Font.custom("Roboto", size: 20).weight(.bold))
                .foregroundColor(Color.yimBeige)
                .frame(width:150)


            }

            VStack{

              Text("\(viewModel.topGenres.first?.genre ?? "")")
                .font(Font.custom("Roboto", size: 32).weight(.bold))
                .foregroundColor(Color.yimBeige)

              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 52, height: 1)
                .overlay(
                  Rectangle()
                    .stroke(Color(red: 0.94, green: 0.93, blue: 0.89), lineWidth: 0.50)

                )

              Text("was my cover art color")
                .font(Font.custom("Roboto", size: 20).weight(.bold))
                .foregroundColor(Color.yimBeige)
                .frame(width:150)


            }




          }

          Spacer()

          HStack{

            VStack{

              Text("\(String(viewModel.totalListenCount))")
                .font(Font.custom("Roboto", size: 32).weight(.bold))
                .foregroundColor(Color.yimBeige)

              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 52, height: 1)
                .overlay(
                  Rectangle()
                    .stroke(Color(red: 0.94, green: 0.93, blue: 0.89), lineWidth: 0.50)

                )

              Text("songs graced my ears")
                .font(Font.custom("Roboto", size: 20).weight(.bold))
                .foregroundColor(Color.yimBeige)
                .frame(width:150)


            }

            VStack{

              Text(viewModel.daysOfWeek)
                .font(Font.custom("Roboto", size: 32).weight(.bold))
                .foregroundColor(Color.yimBeige)

              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 52, height: 1)
                .overlay(
                  Rectangle()
                    .stroke(Color(red: 0.94, green: 0.93, blue: 0.89), lineWidth: 0.50)

                )

              Text("was my music day")
                .font(Font.custom("Roboto", size: 20).weight(.bold))
                .foregroundColor(Color.yimBeige)
                .frame(width:150)


            }




          }
          Spacer()
          HStack{

            VStack{

              Text("\(String(viewModel.totalReleaseGroupCount))")
                .font(Font.custom("Roboto", size: 32).weight(.bold))
                .foregroundColor(Color.yimBeige)

              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 52, height: 1)
                .overlay(
                  Rectangle()
                    .stroke(Color(red: 0.94, green: 0.93, blue: 0.89), lineWidth: 0.50)

                )

              Text("my level of mystery")
                .font(Font.custom("Roboto", size: 20).weight(.bold))
                .foregroundColor(Color.yimBeige)
                .frame(width:150)


            }

            VStack{

              Text("\(String(viewModel.totalArtistsCount))")
                .font(Font.custom("Roboto", size: 32).weight(.bold))
                .foregroundColor(Color.yimBeige)

              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 52, height: 1)
                .overlay(
                  Rectangle()
                    .stroke(Color(red: 0.94, green: 0.93, blue: 0.89), lineWidth: 0.50)

                )

              Text("was my cover art color")
                .font(Font.custom("Roboto", size: 20).weight(.bold))
                .foregroundColor(Color.yimBeige)
                .frame(width:150)


            }




          }
          Spacer()
          Spacer()

            Image("share")
                .frame(width: 49, height: 49)
          Spacer()


          Text("my stats".uppercased())
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


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return StatsView(viewModel: viewModel)
    }
}

