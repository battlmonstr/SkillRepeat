import SwiftUI

struct NextUpRow: View {
    let skill: Skill

    @Binding var isDoneToday : Bool
    @Binding var isDoneYesterday : Bool

    typealias CalendarViewFactory = (Skill) -> CalendarView?
    let calendarViewFactory: CalendarViewFactory

    @State private var isCalendarShown = false
    
    init(skill : Skill,
         isDoneToday : Binding<Bool>,
         isDoneYesterday : Binding<Bool>,
         calendarViewFactory : @escaping CalendarViewFactory ) {
        self.skill = skill
        self._isDoneToday = isDoneToday
        self._isDoneYesterday = isDoneYesterday
        self.calendarViewFactory = calendarViewFactory
    }

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
            .doneAccent(isDone: self.isDoneToday)

            Button(action: self.doneYesterday) {
                Text("yesterday")
            }
            .buttonStyle(self.buttonStyle)
            .doneAccent(isDone: self.isDoneYesterday)

            Button(action: self.showCalendar) {
                Image(systemName: "calendar")
            }
            .buttonStyle(self.buttonStyle)
            .sheet(isPresented: $isCalendarShown) {
                NavigationView {
                    self.calendarViewFactory(self.skill)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }

    private var buttonStyle: some PrimitiveButtonStyle {
        return BorderlessButtonStyle()
    }

    private func doneToday() {
        self.isDoneToday = !self.isDoneToday
    }

    private func doneYesterday() {
        self.isDoneYesterday  = !self.isDoneYesterday
    }

    private func showCalendar() {
        isCalendarShown = true
    }
}

struct NextUpRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NextUpRow(
                skill: Skills.testInstance.items[0],
                isDoneToday: Binding(
                    get: { true },
                    set: { isSet in }),
                isDoneYesterday: Binding(
                    get: { false },
                    set: { isSet in }),
                calendarViewFactory: { _ in nil }
            )
            NextUpRow(
                skill: Skills.testInstance.items[1],
                isDoneToday: Binding(
                    get: { false },
                    set: { isSet in }),
                isDoneYesterday: Binding(
                    get: { true },
                    set: { isSet in }),
                calendarViewFactory: { _ in nil }
            )
        }
        .previewLayout(.fixed(width: 300, height: 50))
    }
}
