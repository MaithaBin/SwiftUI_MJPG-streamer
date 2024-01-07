//
//  ContentView.swift
//  SwiftUI_MJPEG-streamer
//
//  Created by MaithBin on 2024/01/04.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State var ipAdress:String = ""
    @FocusState  var isActive:Bool
    @State var uiImage: UIImage? = nil
    @State var streamURL = ""
    @State var snapshotURL = ""
    @State var isConnected = false
    
    var body: some View {
        VStack {
            // --- Header --- //
            HStack {
                Text("SwiftUI MJPEG-streamer ")
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
                    isConnected = true
                } label: {
                    Text("Connect")
                        .font(.system(size: 24))
                }
                Spacer()
            }
            
            // --- Stream --- //
            StreamView(url: streamURL)
            
            // --- Save Button --- //
            Button {
                saveImage()
                UIImageWriteToSavedPhotosAlbum(uiImage!, nil, nil, nil)
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            } label: {
                Text("Save")
                    .frame(width: 400,height: 70)
                    .background(Color.blue)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
        }
    }
    
    func saveImage() {
        guard let data = saveImageData() else { return }
        uiImage = UIImage(data: data)
    }

    private func saveImageData() -> Data? {
        guard let url = URL(string: snapshotURL) else { return nil }
        let data = try? Data(contentsOf: url)
        return data
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
