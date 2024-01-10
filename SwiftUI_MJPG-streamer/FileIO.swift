//
//  FileIO.swift
//  SwiftUI_MJPG-streamer
//
//  Created by MaithaBin on 2024/01/09.
//

import Foundation
import UIKit

class FileIO: ObservableObject {
    
    let fileManager = FileManager.default
    let dateFormatter = DateFormatter()
    
    /// Gets today's date for the folder name.
    func getCurrentDate() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }
    
    /// Gets current time for the file name.
    func getCurrentTime() -> String {
        dateFormatter.dateFormat = "HH-mm-ss"
        let currentTime = dateFormatter.string(from: Date())
        return currentTime
    }
    
    /// Creates a folder with today's date.
    func createImgFolder() {
        // Gets today's date(JST)
        let todayDate = getCurrentDate()
        
        // Create a folder under Document.
        let folderURL = URL(string: "file://" + NSHomeDirectory() + "/Documents/")
        let directory = folderURL!.appendingPathComponent(todayDate, isDirectory: true)
        print("directory = \(directory)")
        do {
            try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            NSLog("Failed to create a folder")
        }
    }
    
    /// save a snapshot into the specific folder
    func saveImgFile(img:UIImage) {
        let currentTime = getCurrentTime()
        let folderName = getCurrentDate()
        do{
            try img.pngData()?.write(to: URL(fileURLWithPath: NSHomeDirectory() + "/Documents/\(folderName)/\(currentTime).png" ))
        }catch{
            NSLog("Failed to create a folder")
        }
    }
    
}
