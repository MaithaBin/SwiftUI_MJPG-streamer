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
    @State var shootingInterval = "1"
    @State var ipAdress:String = ""
    @FocusState var isActive:Bool
    @State var uiImage: UIImage? = nil
    @State var streamURL = ""
    @State var snapshotURL = ""
    @State var isConnected = false
    @State var textButton = "Start"
    @State var buttonColor = Color.blue
    @State var isStartedCapturing = false
    @State var timer :Timer?
    
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
            
            // --- Input Form: Shooting Interval --- //
            HStack {
                Spacer()
                    .frame(width:10)
                Text("Shooting Interval")
                    .font(.system(size: 24))
                Spacer()
            }
            Spacer()
                .frame(height:0)
            HStack {
                Spacer()
                    .frame(width:10)
                TextField("", text: $shootingInterval)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(TextAlignment.trailing)
                    .frame(width: 250,height: 40)
                    .keyboardType(.numberPad)
                    .border(Color.black, width: 0.5)
                    .font(.system(size: 24))
                    .focused($isActive)
                Text("sec")
                    .font(.system(size: 24))
                Spacer()
            }

            // --- Input Form: IP Adress --- //
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
                TextField("input here.", text: $ipAdress)
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
            
            // --- Start/Stop Button --- //
            Button {
                if isStartedCapturing {
                    isStartedCapturing = false
                    textButton = "Start"
                    buttonColor = Color.blue
                    timer!.invalidate()
                } else if isConnected && !isStartedCapturing {
                    isStartedCapturing = true
                    textButton = "Stop"
                    buttonColor = Color.red
                    if shootingInterval == "" {
                        shootingInterval = "1"
                    }
                    timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(shootingInterval)!, repeats: true) { _ in
                        saveImage()
                    }
                }
            } label: {
                Text(textButton)
                    .frame(width: 400,height: 70)
                    .background(buttonColor)
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
                            fileio.createImgFolder()
                            fileio.saveImgFile(img: uiImage!)
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
