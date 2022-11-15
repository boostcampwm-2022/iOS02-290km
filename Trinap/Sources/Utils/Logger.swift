//
//  Logger.swift
//  Trinap
//
//  Created by 김세영 on 2022/11/15.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

#if DEBUG
enum Logger {
    
    static func print(_ items: Any, file: String = #file, function: String = #function, line: Int = #line) {
        Swift.print()
        Swift.print("🟢 Log at \(file.components(separatedBy: "/").last ?? "Some File")")
        Swift.print("🟢 function: \(function), line: \(line)")
        Swift.print("🟢")
        Swift.print("🟢", items)
        Swift.print()
    }
    
    static func printArray(_ array: [Any], file: String = #file, function: String = #function, line: Int = #line) {
        Swift.print()
        Swift.print("🟢 Log at \(file.components(separatedBy: "/").last ?? "Some File")")
        Swift.print("🟢 function: \(function), line: \(line)")
        Swift.print("🟢")
        for item in array {
            Swift.print("🟢", item)
        }
        Swift.print()
    }
}
#endif
