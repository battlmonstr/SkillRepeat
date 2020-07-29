import SwiftUI

struct NextUpView: View {
    let skills: Skills

    var body: some View {
        List(skills.items, id: \.name) { skill in
            NextUpRow(skill: skill)
        }
    }
}

struct NextUpView_Previews: PreviewProvider {
    static var previews: some View {
        NextUpView(skills: Skills.testInstance)
    }
}
