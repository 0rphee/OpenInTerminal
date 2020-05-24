//
//  CLionApp.swift
//  OpenInTerminalCore
//
//  Created by Jianing Wang on 2020/5/24.
//  Copyright © 2020 Jianing Wang. All rights reserved.
//

import Foundation

final class CLionApp: Editor {
    
    func open(_ path: String) throws {
        
        guard let url = URL(string: path) else {
            throw OITError.wrongUrl
        }
        
        let source = """
        do shell script "open -a CLion \(url.path.specialCharEscaped)"
        """
        
        let script = NSAppleScript(source: source)!
        
        var error: NSDictionary?
        
        script.executeAndReturnError(&error)
        
        if error != nil {
            throw OITError.cannotAccessApp(EditorType.cLion.rawValue)
        }
    }
    
}
