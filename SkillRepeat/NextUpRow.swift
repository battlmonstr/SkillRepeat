import SwiftUI

struct NextUpRow: View {
    let skill: Skill

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
            NavigationLink(destination: CalendarView(skill: skill)) {
                Image(systemName: "calendar")
            }
        }
    }

    func doneToday() {
    }

    func doneYesterday() {
    }

    func showCalendar() {
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
