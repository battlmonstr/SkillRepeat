import SwiftUI

struct LogView: View {
    @ObservedObject private(set) var log: Log
    @Environment(\.locale) var locale

    var body: some View {
        List {
            ForEach(log.entries, id: \.date) { entry in
                HStack {
                    Text(entry.dateString(locale: self.locale))
                    Text(entry.skill.name)
                }
            }
            .onDelete(perform: self.onDelete)
        }
        .navigationBarTitle("Log")
        .navigationBarItems(trailing: EditButton())
    }

    private func onDelete(offsets: IndexSet) {
        self.log.removeEntries(atOffsets: offsets)
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogView(log: Log.testInstance)
        }
        .environment(\.locale, Locale(identifier: "ru"))
    }
}
