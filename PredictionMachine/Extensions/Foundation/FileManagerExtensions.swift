//
//  FileManagerExtensions.swift
//
//  Created by Eric Ziegler on 3/25/22.
//

import Foundation

extension FileManager {
   
    static func openTextFileNamed(name: String, fileExtension: String) -> String? {
        var result: String?
        if let filePath = Bundle.main.path(forResource: name, ofType: fileExtension) {
            do {
                let contents = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                result = contents
            } catch {
                print(error)
            }
        }
        return result
    }

    static func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }

    static func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
}
