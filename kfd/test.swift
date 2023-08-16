//
//  test.swift
//  kfd
//
//  Created by LL on 27/7/23.
//

import SwiftUtils

public func execCmd(args: [String], fileActions: posix_spawn_file_actions_t? = nil) -> Int32? {
    var fileActions = fileActions
    
    var attr: posix_spawnattr_t?
    posix_spawnattr_init(&attr)
    posix_spawnattr_set_persona_np(&attr, 99, 1)
    posix_spawnattr_set_persona_uid_np(&attr, 0)
    posix_spawnattr_set_persona_gid_np(&attr, 0)
    
    var pid: pid_t = 0
    var argv: [UnsafeMutablePointer<CChar>?] = []
    for arg in args {
        argv.append(strdup(arg))
    }
    
    argv.append(nil)
    
    let result = posix_spawn(&pid, argv[0], &fileActions, &attr, &argv, environ)
    let err = errno
    guard result == 0 else {
        NSLog("Failed")
        NSLog("Error: \(result) Errno: \(err)")
        
        return nil
    }
    
    var status: Int32 = 0
    waitpid(pid, &status, 0)
    
    return status
}
