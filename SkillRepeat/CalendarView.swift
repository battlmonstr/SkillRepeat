import SwiftUI

struct CalendarView: View {
    let skill: Skill

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
        }
    }

    func doneOnDay() {

    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(skill: Skills.testInstance.items[0])
            .environment(\.locale, Locale(identifier: "ru"))
    }
}
