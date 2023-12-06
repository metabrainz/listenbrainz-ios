import SwiftUI

struct OnBoardingView : View{
  @State private var iconsScale: CGFloat = 0.5 


  var body: some View{
    VStack {

      Spacer()
      Text("Welcome To ListenBrainz")
        .font(.system(size: 48, weight: .semibold))
        .padding(.bottom)
      Spacer()

      HStack {
        LBIcon2()
          .fill(Color.color_1)
          .scaleEffect(iconsScale)
          .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
              iconsScale = 1.0
            }
          }

        LBIcon1()
          .fill(Color.color_2)
          .scaleEffect(iconsScale)
          .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
              iconsScale = 1.0
            }
          }
      }
      .frame(width: 300, height: 300)
      Spacer()

      NavigationLink(destination: UserDetailsView()) {
        Text("Next")
          .font(.headline)
      }
      Spacer()
    }
  }

}

struct OnBoardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardingView()

  }
}
