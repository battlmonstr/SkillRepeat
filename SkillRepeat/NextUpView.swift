import SwiftUI

struct NextUpView: View {
    let skills: Skills

    var body: some View {
        List(skills.items, id: \.name) { skill in
            NextUpRow(skill: skill)
        }
        .navigationBarTitle("Next up")
    }
}

struct NextUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NextUpView(skills: Skills.testInstance)
        }
    }
}
