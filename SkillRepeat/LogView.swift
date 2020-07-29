import SwiftUI

struct LogView: View {
    let log: Log
    @Environment(\.locale) var locale

    var body: some View {
        List(log.entries.reversed(), id: \.date) { entry in
            Text(entry.dateString(locale: self.locale))
            Text(entry.skill.name)
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(log: Log.testInstance)
            .environment(\.locale, Locale(identifier: "ru"))
    }
}
