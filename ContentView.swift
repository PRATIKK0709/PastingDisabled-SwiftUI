import SwiftUI
import UIKit

struct ContentView: View {
    @State private var allowPasteText: String = ""
    @State private var noPasteText: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Allow Pasting").font(.headline)) {
                    TextFormView(text: $allowPasteText, allowPaste: true)
                }

                Section(header: Text("No Pasting").font(.headline)) {
                    TextFormView(text: $noPasteText, allowPaste: false)
                }
            }
            .navigationBarTitle("Testing input", displayMode: .inline)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TextFormView: View {
    @Binding var text: String
    let allowPaste: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Enter text:")
                .font(.subheadline)
                .foregroundColor(.secondary)

            TextField("Type here", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onTapGesture {
                    if !allowPaste {
                        clearPasteboard()
                    }
                }
                .overlay(
                    allowPaste ? nil : Image(systemName: "nosign").padding(4),
                    alignment: .trailing
                )
        }
    }

    private func clearPasteboard() {
        UIPasteboard.general.string = ""
    }
}



@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
