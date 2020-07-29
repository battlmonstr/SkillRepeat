import SwiftUI

struct NextUpRow: View {
    let skill: Skill

    @State private var isCalendarShown = false

    var body: some View {
        HStack {
            Text(skill.name)
            Spacer()

            Button(action: self.doneToday) {
                HStack {
                    Image(systemName: "checkmark")
                    Text("today")
                }
            }
            Button(action: self.doneYesterday) {
                Text("yesterday")
            }

            Button(action: showCalendar) {
                Image(systemName: "calendar")
            }
            .sheet(isPresented: $isCalendarShown) {
                NavigationView {
                    CalendarView(skill: self.skill)
                }
            }
        }
    }

    func doneToday() {
    }

    func doneYesterday() {
    }

    func showCalendar() {
        isCalendarShown = true
    }
}

struct NextUpRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NextUpRow(skill: Skills.testInstance.items[0])
            NextUpRow(skill: Skills.testInstance.items[1])
        }
        .previewLayout(.fixed(width: 300, height: 50))
    }
}
