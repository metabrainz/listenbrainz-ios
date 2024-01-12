import SwiftUI
import UIKit

struct YimLastView: View {
    @ObservedObject var viewModel: YIMViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: UIScreen.main.bounds.height)
                .background(Color.yimBeige)

            VStack {
                Spacer()

                Image("greenHeart")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 123, height: 108)
                    .clipped()

                Spacer()

                Text("Wishing you a restful 2024,\nfrom the ListenBrainz team.")
                    .font(Font.custom("Roboto", size: 28))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.3, green: 0.43, blue: 0.32))
                    .frame(width: 400, alignment: .top)

                Spacer()



                Text("If you have questions or feedback, don't hesitate to contact us on our forums, by email, X, BlueSky, or Mastodon\n")
                    .font(Font.custom("Roboto", size: 24).weight(.light))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.22, green: 0.3, blue: 0.23))
                    .frame(width: 400, alignment: .top)


                Spacer()


                ZStack {
                    Rectangle()
                        .foregroundColor(Color.yimGreen)
                        .frame(width: UIScreen.main.bounds.width, height: 160)

                    VStack {
                        Text("Share \(viewModel.userName)'s year")
                            .font(Font.custom("Inter", size: 28).weight(.black))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.yimBeige)

                        HStack {
                            Image("share")
                                .resizable()
                                .frame(width: 49, height: 49)

                            ZStack {
                                Image("prof")
                                    .resizable()
                                    .frame(width: 150, height: 49)

                                Text("Listenbrainz Profile")
                                    .font(Font.custom("Roboto", size: 16).weight(.medium))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.yimBeige)
                                    .frame(width: 190, height: 26, alignment: .top)
                            }

                            ZStack {
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

struct YimLastView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        return YimLastView(viewModel: viewModel)
    }
}
