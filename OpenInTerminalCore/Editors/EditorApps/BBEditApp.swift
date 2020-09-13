//
//  BBEditApp.swift
//  OpenInTerminalCore
//
//  Created by Jianing Wang on 2019/7/21.
//  Copyright © 2019 Jianing Wang. All rights reserved.
//

import Foundation

final class BBEditApp: Editor {
    
    func open(_ paths: [String]) throws {
        
        let checkedPaths = paths.compactMap {
            URL(string: $0)
        }.map {
            $0.path.specialCharEscaped
        }
        
        if checkedPaths.count == 0 {
            throw OITError.wrongUrl
        }
        
        let joinedPaths = checkedPaths.joined(separator: " ")
        
        let source = """
        do shell script "open -a BBEdit \(joinedPaths)"
        """
        
        let script = NSAppleScript(source: source)!
        
        var error: NSDictionary?
        
        script.executeAndReturnError(&error)
        
        if error != nil {
            throw OITError.cannotAccessApp(EditorType.bbedit.rawValue)
        }
    }
    
}
