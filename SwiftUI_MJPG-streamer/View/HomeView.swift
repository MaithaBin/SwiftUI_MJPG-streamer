//
//  HomeView.swift
//  SwiftUI_MJPG-streamer
//
//  Created by admin on 2024/01/11.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var urlModel = URLModel()
    @State var shootingInterval = "1"
    @State var ipAdress:String = ""
    @FocusState var isActive:Bool
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
                Text("SwiftUI MJPG-streamer")
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
                    isConnected = urlModel.isURLValid(inputURL: snapshotURL)
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
                    stopShooting()
                } else if isConnected && !isStartedCapturing {
                    startShooting()
                } else {
                    // do nothing.
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
    
    private func startShooting() {
        isStartedCapturing = true
        textButton = "Stop"
        buttonColor = Color.red
        if shootingInterval == "" {
            shootingInterval = "1"
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(shootingInterval)!, repeats: true) { _ in
            urlModel.saveURLAsImage(imgURL: snapshotURL)
        }
    }
    
    private func stopShooting() {
        isStartedCapturing = false
        textButton = "Start"
        buttonColor = Color.blue
        timer!.invalidate()
    }
}

#Preview {
    HomeView()
}
