import Foundation
import SwiftUI

struct DoneAccent: ViewModifier {
    let isDone: Bool

    func body(content: Content) -> some View {
        return content.accentColor(isDone ? Color(.systemGreen) : Color(.systemBlue))
    }
}

extension View {
    func doneAccent(isDone: Bool) -> some View {
        return self.modifier(DoneAccent(isDone: isDone))
    }
}

