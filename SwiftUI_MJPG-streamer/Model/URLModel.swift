//
//  URL.swift
//  SwiftUI_MJPG-streamer
//
//  Created by admin on 2024/01/11.
//
import SwiftUI
import Foundation

class URLModel: ObservableObject {
    private var fileio = FileIO()
    private var uiImage: UIImage? = nil
    /// Checks if  the input string is valid.
    func isURLValid(inputURL:String) -> Bool {
        // The URL you input will be invalid
        // if it containes full-width characters.
        guard let url = URL(string: inputURL) else {
            NSLog("URL Error")
            return false
        }
        return true
    }
    
    /// Captures the snapshot and saves it into Photos App.
    /// - Note: Please call this method after the isURLValid() method because runtime error might occure if the URL is invalid.
    func saveURLAsImage(imgURL:String) {
        let request = URLRequest(url: URL(string: imgURL)!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Checks for errors
            if let error = error {
                NSLog("Error: \(error)")
                return
            } else {
                // Checks if the response is correct.
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        // The data would be valid if the USB camera module
                        // connects and works properly.
                        if let data = data {
                            NSLog("Succeess!The data was saved.")
                            self.uiImage = UIImage(data: data)
                            self.fileio.createImgFolder()
                            self.fileio.saveImgFile(img: self.uiImage!)
                        } else {
                            // Data might be nil.
                            NSLog("Error: Failed to obtain data.")
                        }
                    } else {
                        NSLog("Error: The URL does not exist.")
                    }
                }
            }
        }.resume()
    }

}
