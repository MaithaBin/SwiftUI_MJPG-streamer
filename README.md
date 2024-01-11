# SwiftUI_MJPG-streamer
[![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.9-Orange?style=flat-square)
<img src="https://img.shields.io/badge/-Debian-A81D33.svg?logo=debian&style=flat">

## Overview
- SwiftUI_MJPG-streamer(Security Camera) is the program that connects MJPG-streamer running on Debian and saves the snapshot into the today's date folder in Files App every the shooting interval you set. When you press the start butotn after connecting to MJPG-streamer, shooting will begin. On the other hand, if you would like to stop shooting, tap the stop button at your timing. Also shooting resumes when you press the start button again. 
- Snapshots are saved as png files in order that you may compress and uncompress them without any loss of quality.
- This application helps you to store smaller amount data than mp4 data. It intends for the needs that you would like to capture a specific scene with small size and not high resolution.

<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/f94bf905-7a0c-4107-b229-6ac0babbb6c6" width="100%" />

## Development Environment
### Software
- MJPG-streamer : https://github.com/jacksonliam/mjpg-streamer

### Hardware
- iPhone 12 mini
- Raspberry Pi 3 model B
- USB Camera Module (Model Name: Akozonbtn0k51m6q)

### OSes
- iOS 16.6
- Debian 11 (bullseye)

### IDE
- Xcode 15.1

## Usage
1. Run MJPG-streamer on Debian and open the SwiftUI-MJPGstreamer on your iPhone.
2. Input the IP address and also modifiy the shooting interval if needed. If the shooting interval is blank, the default value "1" second will be input when pressing the start button.
i.g. 192.168.0.25

<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/0e8fff7a-7d78-4de6-a43d-ce9b033c0980" width="20%" />

3. Tap the Connect. Then the stream will be shown if accessing to the page succeeds. 

<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/b3fba44b-c5ab-443b-b56b-1b827d57fbea" width="20%" />

4. Press the start button at your timing while it is displaying the stream. Each snapshot will be saved every the interval you set at the 2. process. Also Tap the stop button when you would like to finish shooting.
<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/db7d9fa6-b97f-497d-8466-e69f58f23e1e" width="20%" />

5. Close the app and go to the Files App > Browse > On My iPhone > SwiftUI-MJPG-streamer. The saved snapshots are located in the "today's date" folder.

<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/1343b069-065e-4359-bc42-57ffb5d8cc9b" width="20%" />

