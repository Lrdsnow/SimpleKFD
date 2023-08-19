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
    
    @State private var build_check = true
    @State private var device_check = true
    
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
    @State private var whitelist = false
    @State private var supervise = false
    
    private let ogDynamicOptions = ["2796 (iPhone 14 Pro Max)", "2556 (iPhone 14 Pro)", "Auto (iPhone X-14)", "569 (iPhone 8/SE2/SE3)", "570 (iPhone 8+)"]
    @State var ogDynamicOptions_num = [2796, 2556, 0, 569, 570]
    @State var ogDynamicOptions_sel = 0
    @State var ogsubtype = 0
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.745, green: 0.431, blue: 0.902, alpha: 1.0)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Tweaks")) {
                        // Hide Homebar
                        Toggle(isOn: $enableHideHomebar) {
                            HStack(spacing: 20) {
                                Image(systemName: enableHideHomebar ? "eye.slash.circle.fill" : "eye.circle")
                                .foregroundColor(.purple)
                                .imageScale(.large)
                                Text("Hide Home Bar").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)

                        // Hide Dock
                        Toggle(isOn: $enableHideDock) {
                            HStack(spacing: 20) {
                                Image(systemName: enableHideDock ? "eye.slash.circle.fill" : "eye.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Hide Dock").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // Resolution
                        Toggle(isOn: $enableResSet) {
                            HStack(spacing: 20) {
                                Image(systemName: enableResSet ? "arrowtriangle.up.circle.fill" : "arrowtriangle.up.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Change Resolution").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // Resolution Options
                        if enableResSet {
                            Section("Resolution Width:") {
                                TextField("Resolution Width", value: $res_x, formatter: NumberFormatter()).foregroundColor(.purple)
                                    .keyboardType(.numberPad) // Number only keyboard
                            }.foregroundColor(.purple.opacity(0.7))
                            Section("Resolution Height:") {
                                TextField("Resolution Height", value: $res_y, formatter: NumberFormatter()).foregroundColor(.purple)
                                    .keyboardType(.numberPad) // Number only keyboard
                            }.foregroundColor(.purple.opacity(0.7))
                        }
                        
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
                        .tint(.purple)
                        
                        // CC Tweaks
                        Toggle(isOn: $enableCCTweaks) {
                            HStack(spacing: 20) {
                                Image(systemName: enableCCTweaks ? "square.circle.fill" : "square.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Custom CC Icons").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // LS Tweaks
                        Toggle(isOn: $enableLSTweaks) {
                            HStack(spacing: 20) {
                                Image(systemName: enableLSTweaks ? "square.circle.fill" : "square.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Custom Lockscreen Icons").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // Hide LS Icons
                        Toggle(isOn: $hideLSIcons) {
                            HStack(spacing: 20) {
                                Image(systemName: hideLSIcons ? "eye.slash.circle.fill" : "eye.circle")
                                .foregroundColor(.purple)
                                .imageScale(.large)
                            Text("Hide Lockscreen Icons").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // Hide Notifications
                        Toggle(isOn: $enableHideNotifs) {
                            HStack(spacing: 20) {
                                Image(systemName: enableHideNotifs ? "eye.slash.circle.fill" : "eye.circle")
                                .foregroundColor(.purple)
                                .imageScale(.large)
                            Text("Hide Notification And Media Player Background").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // Enable Dynamic Island
                        Toggle(isOn: $enableDynamicIsland) {
                            HStack(spacing: 20) {
                                Image(systemName: enableDynamicIsland ? "circle.hexagongrid.circle.fill" : "circle.hexagongrid.circle")
                                .foregroundColor(.purple)
                                .imageScale(.large)
                            Text("Set SubType").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // Dynamic Island Options
                        if enableDynamicIsland {
                            Picker("SubType", selection: $ogDynamicOptions_sel) {
                                ForEach(0 ..< ogDynamicOptions.count, id: \.self) {
                                    Text(self.ogDynamicOptions[$0])
                                }
                            }.tint(.purple).foregroundColor(.purple)
                        }
                        
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
                        .tint(.purple)
                        
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
                        .tint(.purple)
                        
                        // Whitelist
                        Toggle(isOn: $whitelist) {
                            HStack(spacing: 20) {
                                Image(systemName: whitelist ? "slash.circle.fill" : "slash.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Whitelist (Test)").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        // Supervise
                        Toggle(isOn: $supervise) {
                            HStack(spacing: 20) {
                                Image(systemName: supervise ? "eye.slash.circle.fill" : "eye.circle")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            Text("Supervise device").font(.headline)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.purple)
                        .tint(.purple)
                        
                        Spacer()
                        
                        Button(action: {
                            puafPages = puafPagesOptions[puafPagesIndex]
                            kfd = do_kopen(UInt64(puafPages), UInt64(puafMethod), UInt64(kreadMethod), UInt64(kwriteMethod), build_check, device_check)
                            if (kfd != 0) {
                                ogsubtype = ogDynamicOptions_num[ogDynamicOptions_sel]
                                if (ogsubtype == 0) {
                                    ogsubtype = Int(UIScreen.main.nativeBounds.height)
                                }
                                let tweaks = enabledTweaks()
                                var cTweaks: [UnsafeMutablePointer<CChar>?] = tweaks.map { strdup($0) }
                                cTweaks.append(nil)
                                cTweaks.withUnsafeMutableBufferPointer { buffer in
                                    do_fun(buffer.baseAddress, Int32(buffer.count - 1), Int32(res_y), Int32(res_x), Int32(ogsubtype))
                                }
                                cTweaks.forEach { free($0) }
                                do_kclose()
                                backboard_respring()
                            } else {
                                errorAlert = true
                            }
                        }) {
                            Text("Apply Tweaks & Respring")
                                .foregroundColor(.purple) // Outline color
                                .frame(maxWidth: .infinity)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.purple, lineWidth: 2) // Outline style
                                )
                        }.background(.black).alert(isPresented: $errorAlert) {
                            Alert(
                                title: Text("Device Unsupported"),
                                message: Text("Try without the extra checks?")
                            )
                        }
                    }
                    .background(Color.clear).listRowBackground(Color.clear).foregroundColor(.purple.opacity(0.7))
                    
                    
                }
                .background(Color.black)
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
            SettingsView(puafPagesIndex: $puafPagesIndex, puafMethod: $puafMethod, kreadMethod: $kreadMethod, kwriteMethod: $kwriteMethod, build_check: $build_check, device_check: $device_check, res_y: $res_y, res_x: $res_x, puafPages: $puafPages, errorAlert: $errorAlert, kfd: $kfd)
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
            if whitelist {
                enabledTweaks.append("whitelist")
            }
            if supervise {
                enabledTweaks.append("supervise")
            }

            return enabledTweaks
        }
}

struct SettingsView: View {
    @Binding var puafPagesIndex: Int
    @Binding var puafMethod: Int
    @Binding var kreadMethod: Int
    @Binding var kwriteMethod: Int
    @Binding var build_check: Bool
    @Binding var device_check: Bool
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
                }.tint(.purple).foregroundColor(.purple)

                Picker("puaf method:", selection: $puafMethod) {
                    ForEach(0 ..< puafMethodOptions.count, id: \.self) {
                        Text(self.puafMethodOptions[$0])
                    }
                }.tint(.purple).foregroundColor(.purple)

                Picker("kread method:", selection: $kreadMethod) {
                    ForEach(0 ..< kreadMethodOptions.count, id: \.self) {
                        Text(self.kreadMethodOptions[$0])
                    }
                }.tint(.purple).foregroundColor(.purple)

                Picker("kwrite method:", selection: $kwriteMethod) {
                    ForEach(0 ..< kwriteMethodOptions.count, id: \.self) {
                        Text(self.kwriteMethodOptions[$0])
                    }
                }.tint(.purple).foregroundColor(.purple)
                
                Toggle(isOn: $build_check) {
                    Text("iOS Build Check")
                }.tint(.purple).foregroundColor(.purple)
                
                Toggle(isOn: $device_check) {
                    Text("Device ID Check")
                }.tint(.purple).foregroundColor(.purple)
            }.background(Color.clear).listRowBackground(Color.clear).foregroundColor(.purple.opacity(0.7))
            
            Section(header: Text("Misc.")) {
                Button("Unsupervise") {
                    puafPages = puafPagesOptions[puafPagesIndex]
                    kfd = do_kopen(UInt64(puafPages), UInt64(puafMethod), UInt64(kreadMethod), UInt64(kwriteMethod), build_check, device_check)
                    if (kfd != 0) {
                        supervised(false)
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
                        message: Text("Try without the extra checks?")
                    )
                }
            }.background(Color.clear).listRowBackground(Color.clear).foregroundColor(.purple.opacity(0.7))
            
            Section(header: Text("Extras")) {
                Button(action: {
                    respring()
                }) {
                    Text("Respring")
                        .foregroundColor(.purple) // Outline color
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple, lineWidth: 2) // Outline style
                        )
                }
                
                Button(action: {
                    backboard_respring()
                }) {
                    Text("Backboard Respring")
                        .foregroundColor(.purple) // Outline color
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple, lineWidth: 2) // Outline style
                        )
                }
            }.background(Color.clear).listRowBackground(Color.clear).foregroundColor(.purple.opacity(0.7))
        }.navigationBarTitle("Settings", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
