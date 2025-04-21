//
//  FeedHelper.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/07/24.
//

import SwiftUI

struct TextViewRepresentable: UIViewRepresentable {
    let text: String
    let linkColor: Color
    let foregroundColor: Color

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = [.link]
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        let attributedString = NSMutableAttributedString(string: text)
        let regex = try! NSRegularExpression(pattern: "<a href=\"([^\"]+)\">([^<]+)</a>")
        let nsText = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsText.length))

        for match in matches {
            let urlRange = match.range(at: 1)
            let linkTextRange = match.range(at: 2)

            let url = nsText.substring(with: urlRange)
            let linkText = nsText.substring(with: linkTextRange)
            let linkAttributedString = NSAttributedString(string: linkText, attributes: [
                .link: URL(string: url)!,
                .foregroundColor: UIColor(linkColor),
            ])

            attributedString.replaceCharacters(in: match.range(at: 0), with: linkAttributedString)
        }

        uiView.attributedText = attributedString
        uiView.textColor = UIColor(foregroundColor)
        uiView.tintColor = UIColor(linkColor)
    }
}

struct DismissableTextView: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: DismissableTextView

        init(parent: DismissableTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.returnKeyType = .done
        textView.backgroundColor = UIColor.systemGray6  // ??
        textView.layer.cornerRadius = 5
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

func formatDate(epochTime: TimeInterval) -> String {
  let date = Date(timeIntervalSince1970: epochTime)
  let currentDate = Date()
  let difference = currentDate.timeIntervalSince(date)

  if difference < 3600 {
    let minutes = Int(difference / 60)
    return "\(minutes) mins ago"
  } else if difference < 24 * 60 * 60 {
    let hours = Int(difference / 3600)
    return "\(hours) hours ago"
  } else {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, h a"
    return dateFormatter.string(from: date)
  }
}
