//
//  YimLandingView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct YimLandingView: View{
  @ObservedObject var viewModel: YIMViewModel

   init(viewModel: YIMViewModel) {
       self.viewModel = viewModel
   }

  var body: some View{

    ZStack{

      Rectangle()
        .foregroundColor(.clear)
        .frame(height: UIScreen.main.bounds.height)
        .background(Color.yimBeige)


      VStack{

        Spacer()

        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 160, height: 31)
          .background(
            Image("pyc")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 160, height: 31)
              .clipped()
          )



        ZStack() {
            Ellipse()
            .foregroundColor(Color.yimGreen)
                .frame(width: 32, height: 32)
                .offset(x: -64.50, y: 0)

            Ellipse()
            .foregroundColor(Color.yimRed)
                .frame(width: 32, height: 32)
                .offset(x: -21.50, y: 0)

            Ellipse()
            .foregroundColor(Color.yimAqua)
                .frame(width: 32, height: 32)
                .offset(x: 21.50, y: 0)

            Ellipse()
            .foregroundColor(Color.yimBrown)
                .frame(width: 32, height: 32)
                .offset(x: 64.50, y: 0)
        }
        .frame(width: 161, height: 32)
        Spacer()

        Text("#YEARINMUSIC")
          .font(
            Font.custom("Inter", size: 23)
              .weight(.black)
          )
          .tracking(14)
          .multilineTextAlignment(.center)
          .foregroundColor(Color.yimGreen)

        Spacer()

        ZStack{
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 276.94778, height: 92.51109)
            .background(
              VStack{
                Image("plant")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 80, height: 132)
                  .padding(.trailing,60)
                  .padding(.bottom,-75)
                Image("2023Numeric")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 300, height: 110)
              }


            )
        }
        Spacer()
        Spacer()

        Image("arrow")
        .resizable()
        .frame(width: 25, height: 25)
        .aspectRatio(contentMode: .fit)



        ZStack{

          Rectangle()
            .foregroundColor(.clear)
            .frame(width: UIScreen.main.bounds.width, height: 159.99997)
            .background(Color.yimGreen)

          VStack{
            Text(viewModel.userName)
              .font(
                Font.custom("Inter", size: 26)
                  .weight(.black)
              )
              .kerning(15)
              .multilineTextAlignment(.center)
              .foregroundColor(Color.yimBeige)

            HStack{

              Image("share")
                .resizable()
              .frame(width: 49, height: 49)

              ZStack{
                Image("prof")
                .resizable()
                .frame(width: 150, height: 49)

                Text("Listenbrainz Profile")
                  .font(
                    Font.custom("Roboto", size: 16)
                      .weight(.medium)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.yimBeige)
                  .frame(width: 190, height: 26, alignment: .top)
              }
              ZStack{
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 49, height: 49)
                  .background(Color(red: 0.15, green: 0.19, blue: 0.15))
                  .cornerRadius(4)
                  .overlay(
                    RoundedRectangle(cornerRadius: 4)
                      .inset(by: 1)
                      .stroke(Color(red: 0.15, green: 0.19, blue: 0.15), lineWidth: 2)
                  )
                Image("user-plus")
                  .resizable()
                .frame(width: 30.625, height: 30.625)

              }
            }


          }


        }



      }
    }




  }



}





struct YimLandingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return YimLandingView(viewModel: viewModel)
    }
}
