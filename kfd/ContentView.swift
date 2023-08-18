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
    
    @State private var extra_checks = true
    
    @State private var errorAlert = false
    
    @State private var res_y = 2796
    @State private var res_x = 1290
    
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
    @State private var changeRegion = false

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
                                Image(systemName: enableResSet ? "arrowshape.up.circle.fill" : "arrowshape.up.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Change Resolution").font(.headline)
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
                        
                        // Region Changer
                        Toggle(isOn: $changeRegion) {
                            HStack(spacing: 20) {
                                Image(systemName: changeRegion ? "globe.americas.fill" : "globe.americas")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Change Region").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        
                        Spacer()
                    
                        Button("Apply Tweaks & Respring") {
                                puafPages = puafPagesOptions[puafPagesIndex]
                                kfd = do_kopen(UInt64(puafPages), UInt64(puafMethod), UInt64(kreadMethod), UInt64(kwriteMethod), extra_checks)
                                if (kfd != 0) {
                                    let tweaks = enabledTweaks()
                                    var cTweaks: [UnsafeMutablePointer<CChar>?] = tweaks.map { strdup($0) }
                                    cTweaks.append(nil)
                                    cTweaks.withUnsafeMutableBufferPointer { buffer in
                                        do_fun(buffer.baseAddress, Int32(buffer.count - 1), Int32(res_y), Int32(res_x))
                                    }
                                    cTweaks.forEach { free($0) }
                                    do_kclose()
                                    backboard_respring()
                                } else {
                                    errorAlert = true
                                }
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.purple)
                            .alert(isPresented: $errorAlert) {
                                Alert(
                                    title: Text("Device Unsupported"),
                                    message: Text("Try without extra checks?")
                                )
                            }
                        
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
            SettingsView(puafPagesIndex: $puafPagesIndex, puafMethod: $puafMethod, kreadMethod: $kreadMethod, kwriteMethod: $kwriteMethod, extra_checks: $extra_checks, res_y: $res_y, res_x: $res_x, puafPages: $puafPages, errorAlert: $errorAlert, kfd: $kfd)
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
            if changeRegion {
                enabledTweaks.append("changeRegion")
            }

            return enabledTweaks
        }
}

struct SettingsView: View {
    @Binding var puafPagesIndex: Int
    @Binding var puafMethod: Int
    @Binding var kreadMethod: Int
    @Binding var kwriteMethod: Int
    @Binding var extra_checks: Bool
    @Binding var res_y: Int
    @Binding var res_x: Int

    private let puafPagesOptions = [16, 32, 64, 128, 256, 512, 1024, 2048]
    private let puafMethodOptions = ["physpuppet", "smith"]
    private let kreadMethodOptions = ["kqueue_workloop_ctl", "sem_open"]
    private let kwriteMethodOptions = ["dup", "sem_open"]
    
    // Dyanmic Island Stuff
    private let ogDynamicOptions = ["Auto (iPhone X-14)", "569 (iPhone 8/SE2/SE3)", "570 (iPhone 8+)"]
    @State var ogDynamicOptions_num = [0, 569, 570]
    @State var ogDynamicOptions_sel = 0
    @State var ogsubtype = 0
    
    // temp stuff to start kfd
    @Binding var puafPages: Int
    @Binding var errorAlert: Bool
    @Binding var kfd: UInt64
    
    var body: some View {
        Form {
            Section(header: Text("Exploit Settings")) {
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
                
                Toggle(isOn: $extra_checks) {
                    Text("extra offset checks")
                }
            }
            
            Section(header: Text("Resolution")) {
                Text("Resolution Width:")
                TextField("Resolution Width", value: $res_x, formatter: NumberFormatter())
                Text("Resolution Height:")
                TextField("Resolution Height", value: $res_y, formatter: NumberFormatter())
            }
            
            Section(header: Text("Dynamic Island")) {
                Picker("Original SubType:", selection: $ogDynamicOptions_sel) {
                    ForEach(0 ..< ogDynamicOptions.count, id: \.self) {
                        Text(self.ogDynamicOptions[$0])
                    }
                }
                Button("Revert SubType") {
                    puafPages = puafPagesOptions[puafPagesIndex]
                    kfd = do_kopen(UInt64(puafPages), UInt64(puafMethod), UInt64(kreadMethod), UInt64(kwriteMethod), extra_checks)
                    if (kfd != 0) {
                        ogsubtype = ogDynamicOptions_num[ogDynamicOptions_sel]
                        if (ogsubtype == 0) {
                            ogsubtype = Int(UIScreen.main.nativeBounds.height)
                        }
                        DynamicKFD(Int32(ogsubtype))
                        do_kclose()
                        backboard_respring()
                    } else {
                        errorAlert = true
                    }
                }.frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.purple)
                .alert(isPresented: $errorAlert) {
                    Alert(
                        title: Text("Device Unsupported"),
                        message: Text("Try without extra checks?")
                    )
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
                    .background(.purple)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    backboard_respring()
                }) {
                    Text("Backboard Respring")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.purple)
                    .cornerRadius(10)
                }
            }
        }.navigationBarTitle("Settings", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
