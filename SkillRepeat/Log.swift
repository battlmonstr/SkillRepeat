import Foundation
import SwiftDate

struct LogEntry: Codable {
    let date: Date
    let skill: Skill

    func dateString(locale: Locale) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short;
        formatter.timeStyle = .none;
        formatter.locale = locale
        return formatter.string(from: self.date)
    }
}

struct LogEntryList: Codable {
    let entries: [LogEntry]
}

class Log: ObservableObject {
    private(set) var entries: [LogEntry]

    init(_ entries: [LogEntry]) {
        self.entries = entries
    }

    convenience init(jsonFileName: String) {
        var entries: [LogEntry] = []

        if let docsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let logFileURL = docsDir.appendingPathComponent(jsonFileName)
            if let logData = try? Data(contentsOf: logFileURL) {
                let decoder = JSONDecoder()
                if let logEntryList = try? decoder.decode(LogEntryList.self, from: logData) {
                    entries = logEntryList.entries
                }
            }
        }

        self.init(entries)
    }

    func isDoneToday(_ skill: Skill) -> Bool {
        return isDoneOnDay(day: Date(), skill: skill)
    }

    func isDoneYesterday(_ skill: Skill) -> Bool {
        return isDoneOnDay(day: Date().dateAt(.yesterday), skill: skill)
    }

    func isDoneOnDay(day: Date, skill: Skill) -> Bool {
        return entries.contains { ($0.skill == skill) && $0.date.compare(.isSameDay(day)) }
    }

    func toggleDoneToday(_ skill: Skill) {
        toggleDoneOnDay(day: Date(), skill: skill)
    }

    func toggleDoneYesterday(_ skill: Skill) {
        toggleDoneOnDay(day: Date().dateAt(.yesterday), skill: skill)
    }

    func toggleDoneOnDay(day: Date, skill: Skill) {
        if isDoneOnDay(day: day, skill: skill) {
            removeDayEntries(day: day, skill: skill)
        } else {
            addEntry(date: day, skill: skill)
        }
    }

    private func addEntry(date: Date, skill: Skill) {
        entries.append(LogEntry(date: date, skill: skill))
        entries.sort(by: { $0.date < $1.date })
        self.objectWillChange.send()
    }

    private func removeDayEntries(day: Date, skill: Skill) {
        entries.removeAll { ($0.skill == skill) && $0.date.compare(.isSameDay(day)) }
        self.objectWillChange.send()
    }

    static var testInstance: Log {
        let skills = Skills.testInstance.items

        let dayInterval: TimeInterval = 24 * 3600
        let day1 = Date(timeIntervalSinceNow: -dayInterval * 2)
        let day2 = Date(timeIntervalSinceNow: -dayInterval * 1)
        let day3 = Date(timeIntervalSinceNow: -dayInterval * 0)

        return Log([
            LogEntry(date: day1, skill: skills[0]),
            LogEntry(date: day2, skill: skills[0]),
            LogEntry(date: day2.addingTimeInterval(1), skill: skills[1]),
            LogEntry(date: day3, skill: skills[2]),
        ])
    }
}
