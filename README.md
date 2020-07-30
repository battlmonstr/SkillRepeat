# SkillRepeat

This app is showcasing SwiftUI:

* composable views with previews
* List with onDelete
* List with multiple buttons in a row
* reusable screens that can be used in a tab or a navigation VC or as a popup sheet
* a custom view modifier - DoneAccent
* how to create the models in AppDelegate once
* subscribe to ObservableObject manually
* works on macOS


## SwiftUI WTFs

* disk space gone!!! (a lot of simulators under the hood)
* BorderlessButtonStyle - to have several buttons in a List table cell (otherwise the whole row gets clicked and all buttons click)
* @Environment(\.locale) - for custom strings have to pass it explicitly
* if a view builder returns nil - the view is ignored silently
* to return a generic View from a factory - might use AnyView (but it is a bad practice)
* some builders with blocks (as `ForEach`) might error with "() cannot conform to View" - might use Group or a stack view
* StackNavigationViewStyle - to avoid creating a split VC in NavigationView
* to create bindings for previews - make a local `@State`
* using `weak` for button actions is not really necessary, because it operates on a copy of "self" (but possible if the block is not capturing "self")
