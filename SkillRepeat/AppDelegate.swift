import UIKit
import Combine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private(set) var skills: Skills!
    private(set) var log: Log!

    private var logStore: LogStore!
    private var logStoreUpdater: AnyCancellable!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let skillsStore = SkillsStore("skills.txt", resourceName: "street_workout_skills.txt")
        self.skills = Skills((try? skillsStore.loadAndParse()) ?? [], store: skillsStore)
        self.logStore = LogStore(jsonFileName: "log.json")
        self.log = Log((try? logStore.load()) ?? [])
        self.logStoreUpdater = startUpdatingLogStore()
        return true
    }

    private func startUpdatingLogStore() -> AnyCancellable {
        return log.objectWillChange.sink { [weak self] in
            if let entries = self?.log.entries {
                do {
                    try self?.logStore.save(entries: entries)
                } catch {
                    print("logStore.save error: \(error)")
                }
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

