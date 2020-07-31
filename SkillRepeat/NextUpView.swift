import SwiftUI

struct NextUpView: View {
    let skills: Skills
    @ObservedObject private(set) var log: Log

    var body: some View {
        List(log.sortSkillsByDeadline(skills: skills), id: \.name) { skill in
            NextUpRow(
                skill: skill,
                isDoneToday: self.isDoneTodayBinding(skill),
                isDoneYesterday: self.isDoneYesterdayBinding(skill),
                calendarViewFactory: self.calendarViewFactory())
        }
        .navigationBarTitle("Next up")
    }

    private func calendarViewFactory() -> NextUpRow.CalendarViewFactory {
        weak var weakLog = self.log
        return { skill in
            if let log = weakLog {
                return CalendarView(skill: skill, log: log)
            }
            return nil
        }
    }

    private func isDoneTodayBinding(_ skill: Skill) -> Binding<Bool> {
        return Binding(
            get: { self.log.isDoneToday(skill) },
            set: { _ in self.log.toggleDoneToday(skill) }
        )
    }

    private func isDoneYesterdayBinding(_ skill: Skill) -> Binding<Bool> {
        return Binding(
            get: { self.log.isDoneYesterday(skill) },
            set: { _ in self.log.toggleDoneYesterday(skill) }
        )
    }
}

struct NextUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NextUpView(
               skills: Skills.testInstance,
               log: Log.testInstance)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
