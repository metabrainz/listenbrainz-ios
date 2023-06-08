//
//  HomeView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//

import SwiftUI


struct AdaptiveImage: View {
    @Environment(\.colorScheme) var colorScheme
    let light: Image
    let dark: Image

    @ViewBuilder var body: some View {
        if colorScheme == .light {
            light
        } else {
            dark
        }
    }
}
struct HomeView : View{

  var body: some View{

    NavigationView{
      ScrollView{

//       .padding(.top, 12).padding(.horizontal)

        VStack(alignment: .center ,spacing: 0){



          AdaptiveImage(light: Image("listenBrainzLight")
            , dark: Image("listenBrainzDark"))



          HStack(spacing: 0){
            Text("Listen")
              .foregroundColor(.init(red: 0.20, green: 0.19, blue: 0.42))

            Text("Brainz")
              .foregroundColor(.init(red: 0.86, green: 0.49, blue: 0.29))

          }
          .font(.largeTitle)
          .fontWeight(.bold)

        }
//        .padding(.all)
//        .navigationTitle("ListenBrainz")

        VStack(spacing: 10){
          HStack(alignment: .center, spacing: 0) {
            Image(systemName: "radio")
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 65).cornerRadius(16)
              .foregroundColor(.init(red: 0.86, green: 0.49, blue: 0.29))
            VStack(alignment: .leading, spacing: 8) {
              Text("Year in Music")
                .lineLimit(1)
                .font(.headline)

              Text("Your Whole Year Summarized")


            }
            .padding(.leading, 12)
            Spacer()
          }
          .padding(12)
          .background(Color.gray.opacity(0.15))


          HStack(alignment: .center, spacing: 0) {
            Image(systemName: "mic")
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 65).cornerRadius(16)
              .foregroundColor(.init(red: 0.86, green: 0.49, blue: 0.29))
            VStack(alignment: .leading, spacing: 8) {
              Text("News")
                .lineLimit(1)
                .font(.headline)

              Text("ListenBrainz News Updates")


            }
            .padding(.leading, 12)
            Spacer()
          }
          .padding(12)
          .background(Color.gray.opacity(0.15))

        }

      }
      .toolbar{
        HStack(spacing: 0) {
          Button(action: {  }) {
              Image("listenBrainzDark")
              .resizable()
              .frame(width: 40, height: 40)
              .padding(12)
              .cornerRadius(20)
              .clipShape(Circle())
          }
            Text("ListenBrainz")
            .font(.system(size:28))
            .fontWeight(.bold)
        }


        HStack(spacing: 2){
            Button(action: {  }) {
              Image(systemName: "info.circle")
            }
            Button(action: {  }) {
              Image(systemName: "exclamationmark.circle")
            }
            Button(action: {  }) {
              Image(systemName: "gear")
              //                .resizable().frame(width: 26, height: 26)
              //                    .padding(12)
              //                    .cornerRadius(20)
            }
          }
        .foregroundColor(.init(red: 0.86, green: 0.49, blue: 0.29))
        }

      }





    }
  }



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()

    }
}
