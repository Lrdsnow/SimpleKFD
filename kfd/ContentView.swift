import SwiftUI

struct ContentView: View {
    @State private var kfd: UInt64 = 0

    private let puafPagesOptions = [16, 32, 64, 128, 256, 512, 1024, 2048]
    @State private var puafPagesIndex = 7
    @State private var puafPages = 0

    private let puafMethodOptions = ["physpuppet", "smith"]
    @State private var puafMethod = 1

    private let kreadMethodOptions = ["kqueue_workloop_ctl", "sem_open"]
    @State private var kreadMethod = 1

    private let kwriteMethodOptions = ["dup", "sem_open"]
    @State private var kwriteMethod = 1
    
    @State private var enableHideDock = false
    @State private var enableCCTweaks = false
    @State private var enableLSTweaks = false
    @State private var enableCustomFont = false
    @State private var enableResSet = false
    @State private var enableHideHomebar = false
    @State private var enableHideNotifs = false
    @State private var hideLSIcons = false
    @State private var enableCustomSysColors = false
    @State private var enableDynamicIsland = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Tweaks")) {
                        // Hide Homebar
                        Toggle(isOn: $enableHideHomebar) {
                            HStack(spacing: 20) {
                                Image(systemName: enableHideHomebar ? "rectangle.grid.1x2.fill" : "rectangle.grid.1x2")
                                .foregroundColor(.purple)
                                .imageScale(.large)
                                Text("Hide Home Bar").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)

                        // Hide Dock
                        Toggle(isOn: $enableHideDock) {
                            HStack(spacing: 20) {
                                Image(systemName: enableHideDock ? "eye.slash" : "eye")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Hide Dock").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // Resolution
                        Toggle(isOn: $enableResSet) {
                            HStack(spacing: 20) {
                                Image(systemName: enableResSet ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Enable 14 Pro Max Resolution").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // Custom Font
                        Toggle(isOn: $enableCustomFont) {
                            HStack(spacing: 20) {
                                Image(systemName: enableCustomFont ? "a.circle.fill" : "a.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Change Font (Hardcoded)").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // CC Tweaks
                        Toggle(isOn: $enableCCTweaks) {
                            HStack(spacing: 20) {
                                Image(systemName: enableCCTweaks ? "pencil.circle.fill" : "pencil.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Custom CC Icons").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // LS Tweaks
                        Toggle(isOn: $enableLSTweaks) {
                            HStack(spacing: 20) {
                                Image(systemName: enableLSTweaks ? "pencil.circle.fill" : "pencil.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Custom Lockscreen Icons").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // Hide LS Icons
                        Toggle(isOn: $hideLSIcons) {
                            HStack(spacing: 20) {
                                Image(systemName: hideLSIcons ? "pencil.circle.fill" : "pencil.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Hide Lockscreen Icons").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // Hide Notifications
                        Toggle(isOn: $enableHideNotifs) {
                            HStack(spacing: 20) {
                                Image(systemName: enableHideNotifs ? "pencil.circle.fill" : "pencil.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Hide Notification And Media Player Background").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // Enable Dynamic Island
                        Toggle(isOn: $enableDynamicIsland) {
                            HStack(spacing: 20) {
                                Image(systemName: enableDynamicIsland ? "pencil.circle.fill" : "pencil.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Enable dynamic island").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        // Enable Custom System Colors
                        Toggle(isOn: $enableCustomSysColors) {
                            HStack(spacing: 20) {
                                Image(systemName: enableCustomSysColors ? "drop.circle.fill" : "drop.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Purple System & Font Color").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        Spacer()
                        
                        Button("Apply Tweaks & Respring") {
                                puafPages = puafPagesOptions[puafPagesIndex]
                                kfd = do_kopen(UInt64(puafPages), UInt64(puafMethod), UInt64(kreadMethod), UInt64(kwriteMethod))
                                let tweaks = enabledTweaks()
                                var cTweaks: [UnsafeMutablePointer<CChar>?] = tweaks.map { strdup($0) }
                                cTweaks.append(nil)
                                cTweaks.withUnsafeMutableBufferPointer { buffer in
                                    do_fun(buffer.baseAddress, Int32(buffer.count - 1))
                                }
                                cTweaks.forEach { free($0) }
                                do_kclose()
                                backboard_respring()
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(kfd == 0 ? .purple : .purple.opacity(0.5))
                        
                    }
                    .listRowBackground(Color.clear)
                }
                .navigationBarTitle("SimpleKFD", displayMode: .inline)
                .navigationBarItems(trailing: navigationLink)
            }
        }
    }
    
    private var navigationLink: some View {
            NavigationLink(destination: settingsView) {
                Text("Settings")
                    .foregroundColor(.purple)
            }
        }
        
        private var settingsView: some View {
            SettingsView(puafPagesIndex: $puafPagesIndex, puafMethod: $puafMethod, kreadMethod: $kreadMethod, kwriteMethod: $kwriteMethod)
                .navigationBarTitle("Settings")
        }
    
    private func enabledTweaks() -> [String] {
            var enabledTweaks: [String] = []
            if enableHideDock {
                enabledTweaks.append("HideDock")
            }
            if enableHideHomebar {
                enabledTweaks.append("enableHideHomebar")
            }
            if enableResSet {
                enabledTweaks.append("enableResSet")
            }
            if enableCustomFont {
                enabledTweaks.append("enableCustomFont")
            }
            if enableCCTweaks {
                enabledTweaks.append("enableCCTweaks")
            }
            if enableLSTweaks {
                enabledTweaks.append("enableLSTweaks")
            }
            if enableHideNotifs {
                enabledTweaks.append("enableHideNotifs")
            }
            if hideLSIcons {
                enabledTweaks.append("hideLSIcons")
            }
            if enableCustomSysColors {
                enabledTweaks.append("enableCustomSysColors")
            }
            if enableDynamicIsland {
                enabledTweaks.append("enableDynamicIsland")
            }

            return enabledTweaks
        }
}

struct SettingsView: View {
    @Binding var puafPagesIndex: Int
    @Binding var puafMethod: Int
    @Binding var kreadMethod: Int
    @Binding var kwriteMethod: Int

    private let puafPagesOptions = [16, 32, 64, 128, 256, 512, 1024, 2048]
    private let puafMethodOptions = ["physpuppet", "smith"]
    private let kreadMethodOptions = ["kqueue_workloop_ctl", "sem_open"]
    private let kwriteMethodOptions = ["dup", "sem_open"]

    var body: some View {
        Form {
            Section(header: Text("Settings")) {
                Picker("puaf pages:", selection: $puafPagesIndex) {
                    ForEach(0 ..< puafPagesOptions.count, id: \.self) {
                        Text(String(self.puafPagesOptions[$0]))
                    }
                }

                Picker("puaf method:", selection: $puafMethod) {
                    ForEach(0 ..< puafMethodOptions.count, id: \.self) {
                        Text(self.puafMethodOptions[$0])
                    }
                }

                Picker("kread method:", selection: $kreadMethod) {
                    ForEach(0 ..< kreadMethodOptions.count, id: \.self) {
                        Text(self.kreadMethodOptions[$0])
                    }
                }

                Picker("kwrite method:", selection: $kwriteMethod) {
                    ForEach(0 ..< kwriteMethodOptions.count, id: \.self) {
                        Text(self.kwriteMethodOptions[$0])
                    }
                }
            }
            Section(header: Text("Extras")) {
                Button(action: {
                    respring()
                }) {
                    Text("Respring")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    backboard_respring()
                }) {
                    Text("Backboard Respring")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                }
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
