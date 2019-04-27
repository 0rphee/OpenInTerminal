//
//  AppDelegate.swift
//  OpenInTerminalHelper
//
//  Created by Jianing Wang on 2019/4/27.
//  Copyright © 2019 Jianing Wang. All rights reserved.
//

import Cocoa

//class OpenInTerminalHelperApplication: NSApplication {
//    let strongDelegate = AppDelegate()
//
//    override init() {
//        super.init()
//        self.delegate = strongDelegate
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppIdentifier = "wang.jianing.OpenInTerminal"
        let running = NSWorkspace.shared.runningApplications
        var alreadyRunning = false
        
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            LaunchNotifier.addObserver(observer: NSApp,
                                       selector: #selector(NSApplication.terminate(_:)),
                                       notification: .terminateApp,
                                       object: mainAppIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("OpenInTerminal")
            
            let newPath = NSString.path(withComponents: components)
            NSWorkspace.shared.launchApplication(newPath)
        } else {
            NSApp.terminate(self)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        print("helper app terminated")
    }


}

