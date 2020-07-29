import SwiftUI

struct CalendarView: View {
    let skill: Skill
    @ObservedObject private(set) var log: Log

    private let calendar = Calendar()
    @Environment(\.locale) var locale

    var body: some View {
        List(calendar.recentDays, id: \.self) { day in
            Button(action: self.doneOnDay) {
                HStack {
                    Image(systemName: "checkmark")
                    Text("done")
                    Text("@")
                    Text(Calendar.dateString(date: day, locale: self.locale))
                }
            }
            .buttonStyle(self.buttonStyle)
            .doneAccent(isDone: false)
        }
        .navigationBarTitle(self.skill.name)
    }

    private var buttonStyle: some PrimitiveButtonStyle {
        return BorderlessButtonStyle()
    }

    func doneOnDay() {

    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalendarView(
                skill: Skills.testInstance.items[0],
                log: Log.testInstance)
        }
        .environment(\.locale, Locale(identifier: "ru"))
    }
}
