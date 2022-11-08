//
//  FileManagerService.swift
//  FileManaget_HW
//
//  Created by Alexey Kurazhov on 08.11.2022.
//

import Foundation

import UIKit

struct PathFinder {
    static var shared = PathFinder()
    var currentPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    private init() {}
}

struct contentStruct {
    let name: String
    let isDir: Bool
}

protocol FileManagerServiceProtocol {
    func contentOfDirectory(subDirectory dir: String) -> [contentStruct]
    func createDirectory(subDirectory dir: String)
    func createFile(filePath path: URL, image: UIImage)
    func removeContent(delitingItem url: URL)
}

class FileManagerService: FileManagerServiceProtocol {
    func contentOfDirectory(subDirectory dir: String) -> [contentStruct] {
        var listForReturn = [contentStruct]()
        var isDir: ObjCBool = false
        
        let listDir = try! FileManager.default.contentsOfDirectory(atPath: dir)
        
        listDir.forEach { fileItem in
            if FileManager.default.fileExists(atPath: dir + "/" + fileItem, isDirectory: &isDir) {
                if isDir.boolValue {
                    listForReturn.append(contentStruct(name: fileItem, isDir: true))
                } else {
                    listForReturn.append(contentStruct(name: fileItem, isDir: true))
                }
            }
        }
        return listForReturn
    }
    
    func createDirectory(subDirectory dir: String) {
        do {
            try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true,attributes: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createFile(filePath path: URL, image: UIImage) {
        let imageName = UUID().uuidString + ".jpg"
        let imagePath = path.appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: imagePath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func removeContent(delitingItem url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
    }
}
