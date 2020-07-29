import Foundation

struct Calendar {
    var recentDays: [Date] {
        let dayInterval: TimeInterval = 24 * 3600
        return (0..<30).map { (i: Int) in
            Date(timeIntervalSinceNow: -dayInterval * Double(i))
        }
    }

    static func dateString(date: Date, locale: Locale) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium;
        formatter.timeStyle = .none;
        formatter.locale = locale
        return formatter.string(from: date)
    }
}
