# SwiftUI_MJPG-streamer
[![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.9-Orange?style=flat-square)
<img src="https://img.shields.io/badge/-Debian-A81D33.svg?logo=debian&style=flat">

## Overview
SwiftUI_MJPG-streamer is the code that connects MJPG-streamer running on Debian and saves the snapshot into the Photos App at your timing.

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
1. Run MJPG-streamer on Debian
2. Open the app and input the IP address.
i.g. 192.168.0.25

<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/2c1811ab-ead0-45bf-a96e-e8b5afe5628a" width="20%" />
<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/db8e69d3-de82-44c3-b8e4-e56099964c4e" width="20%" />

3. Tap the Connect. Then the stream will be shown if accessing to the page succeeds. 

<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/fce68267-c8d0-4293-a313-9abcbe0c5aa8" width="20%" />

4. Press the save button at your timing while it is displaying the stream. The snapshot will be saved as long as the stream shows up, or the connection works correctly.
<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/555646a8-293b-4118-af02-5e7c0c2c5ee4" width="20%" />

5. Close the app and go to Photos App to find the snapshot.

<img src="https://github.com/MaithaBin/SwiftUI_MJPG-streamer/assets/141325017/2a1d1393-152a-45d7-904f-62eb68073d6a" width="20%" />


