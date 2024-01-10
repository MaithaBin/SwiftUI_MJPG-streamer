//
//  ContentView.swift
//  SwiftUI_MJPEG-streamer
//
//  Created by MaithBin on 2024/01/04.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @ObservedObject var fileio = FileIO()
    @State var ipAdress:String = ""
    @FocusState var isActive:Bool
    @State var uiImage: UIImage? = nil
    @State var streamURL = ""
    @State var snapshotURL = ""
    @State var isConnected = false
    
    var body: some View {
        VStack {
            // --- Header --- //
            HStack {
                Text("SwiftUI MJPG-streamer ")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            }
            .frame(width: 400,height: 50)
            .background(Color.blue)
            .foregroundColor(Color.white)

            // --- Input Form --- //
            HStack {
                Spacer()
                    .frame(width:10)
                Text("IP Address")
                    .font(.system(size: 24))
                Spacer()
            }
            Spacer()
                .frame(height:0)
            HStack {
                Spacer()
                    .frame(width:10)
                TextField("Input here.", text: $ipAdress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250,height: 40)
                    .keyboardType(.decimalPad)
                    .border(Color.black, width: 0.5)
                    .font(.system(size: 24))
                    .focused($isActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Close") {
                                isActive = false
                            }
                        }
                    }
                Button {
                    streamURL = "http://\(ipAdress):8080/?action=stream"
                    snapshotURL = "http://\(ipAdress):8080/?action=snapshot"
                    isConnected = isURLValid(inputURL: snapshotURL)
                    fileio.createImgFolder()
                } label: {
                    Text("Connect")
                        .font(.system(size: 24))
                }
                Spacer()
            }
            
            // --- Stream --- //
            if isConnected {
                StreamView(url: streamURL)
            } else {
                Spacer()
            }
            
            // --- Save Button --- //
            // wanna change like you can get png file every x sec or min
            Button {
                if isConnected {
                    saveImage()
                }
            } label: {
                Text("Save")
                    .frame(width: 400,height: 70)
                    .background(Color.blue)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
        }
    }
    
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
    func saveImage() {
        let request = URLRequest(url: URL(string: snapshotURL)!)
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
                            uiImage = UIImage(data: data)
                            fileio.saveImgFile(img: uiImage!)
                            //UIImageWriteToSavedPhotosAlbum(uiImage!, nil, nil, nil)
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
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

struct StreamView: UIViewRepresentable {
    let url: String
    
    /// Creates the view object.
    /// This method is only invoked once.
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    /// Updates the view object.
    /// This method is called and updates the view when the current state changes.
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    ContentView()
}
