import SwiftUI

struct NextUpRow: View {
    let skill: Skill
    typealias CalendarViewFactory = (Skill) -> CalendarView?
    let calendarViewFactory: CalendarViewFactory

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
            .buttonStyle(self.buttonStyle)
            .doneAccent(isDone: true)

            Button(action: self.doneYesterday) {
                Text("yesterday")
            }
            .buttonStyle(self.buttonStyle)
            .doneAccent(isDone: false)

            Button(action: showCalendar) {
                Image(systemName: "calendar")
            }
            .buttonStyle(self.buttonStyle)
            .sheet(isPresented: $isCalendarShown) {
                NavigationView {
                    self.calendarViewFactory(self.skill)
                }
            }
        }
    }

    private var buttonStyle: some PrimitiveButtonStyle {
        return BorderlessButtonStyle()
    }

    func doneToday() {
        print("doneToday")
    }

    func doneYesterday() {
        print("doneYesterday")
    }

    func showCalendar() {
        isCalendarShown = true
    }
}

struct NextUpRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NextUpRow(
                skill: Skills.testInstance.items[0],
                calendarViewFactory: { _ in nil })
            NextUpRow(
                skill: Skills.testInstance.items[1],
                calendarViewFactory: { _ in nil })
        }
        .previewLayout(.fixed(width: 300, height: 50))
    }
}
