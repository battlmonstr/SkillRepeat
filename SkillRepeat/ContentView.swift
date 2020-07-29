import SwiftUI

struct ContentView: View {
    let skills: Skills
    let log: Log

    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            NextUpView(skills: skills)
                .tabItem { nextUpTabItem }
                .tag(0)
            LogView(log: log)
                .tabItem { logTabItem }
                .tag(1)
        }
    }

    private var nextUpTabItem: some View {
        VStack {
            Image(systemName: "forward")
            Text("Next up")
        }
    }

    private var logTabItem: some View {
        VStack {
            Image(systemName: "table")
            Text("Log")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            skills: Skills.testInstance,
            log: Log.testInstance)
    }
}
