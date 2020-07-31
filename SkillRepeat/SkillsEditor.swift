import SwiftUI

struct SkillsEditor: View {
    @Binding var skillsText: String

    var body: some View {
        TextView(text: $skillsText)
            .navigationBarTitle("Skills")
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text != text {
            textView.text = text
            textView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator : NSObject, UITextViewDelegate {
        @Binding private var text: String

        init(text: Binding<String>) {
            self._text = text
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            self.text = textView.text
        }
    }
}

struct SkillsEditor_Previews: PreviewProvider {
    private static var skillsText: String {
        return Skills.testInstance.items
            .map({ $0.name })
            .joined(separator: "\n")
    }

    static var previews: some View {
        NavigationView {
            SkillsEditor(skillsText: Binding.constant(skillsText))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
