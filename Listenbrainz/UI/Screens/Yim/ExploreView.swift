//
//  ExploreView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 13/01/24.
//

import SwiftUI


struct ExploreView:View{
  @StateObject var viewModel:YIMViewModel
  @State private var isSettingsPressed = false
  @Environment(\.colorScheme) var colorScheme
  @State private var isSearchActive = false

  var body: some View{

    ZStack {
      colorScheme == .dark ? Color.backgroundColor : Color.white
      VStack{
        if isSearchActive{
          SearchUsersView(isSearchActive: $isSearchActive)
        }
        else{
          VStack(spacing:50){
            TopBar(isSettingsPressed:$isSettingsPressed, isSearchActive: $isSearchActive, customText: "Explore")

            Spacer()

            Text("your #yearinmusic".uppercased())
              .font(.system(size: 30, weight: .bold))
              .kerning(10)
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 0.3, green: 0.43, blue: 0.32))



            NavigationLink(destination: MainView(viewModel: viewModel)) {
              VStack() {

                HStack {
                  VStack(alignment: .leading) {
                    Text("Year In Music")
                      .font(.headline)
                      .fontWeight(.bold)
                      .foregroundColor(Color.yimGreen)
                      .padding(.top)

                    Text("Review")
                      .foregroundColor(Color.yimGreen)
                  }
                  Spacer()

                  Image(systemName: "hands.sparkles")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .colorMultiply(Color.yimGreen)

                }
                .padding(.horizontal)
                Spacer()

                VStack{
                  Image("plant")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 92)
                    .padding(.trailing,60)
                    .padding(.bottom,-60)
                  Image("2023Numeric")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 90)
                }
                Spacer()
              }
              .frame(width: UIScreen.main.bounds.size.width, height: 200)
              .background(Color.yimBeige)
              .cornerRadius(10)
              .shadow(radius: 10)

            }


          }
          .sheet(isPresented: $isSettingsPressed) {
            SettingsView()
          }
          .padding(.bottom,250)
        }
      }
    }
  }
}
