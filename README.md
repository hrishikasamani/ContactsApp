# iOS Contacts App

This is a simple **iOS Contacts App** built using Swift without storyboards. The app allows users to add, view, edit, and delete contacts. It includes features like input validation, profile picture selection using the camera or gallery, and a fully responsive programmatic UI.

## Table of Contents
- [Features](#features)
- [Screens](#screens)
- [Requirements](#requirements)
- [Installation](#installation)
- [Setup](#setup)
- [Usage](#usage)
- [Contact](#contact)

## Features
- **Add New Contacts**: Input fields for name, phone number, email, address, and profile picture.
- **Edit & Delete Contacts**: Update or remove existing contacts.
- **Data Validation**: Ensures valid email, phone numbers, and zip codes.
- **Profile Picture Support**: Choose images from the camera or photo library.
- **Responsive UI**: Built programmatically using UIKit with Auto Layout.
- **Persistent Data Storage**: Saves contacts data using UserDefaults.

## Screens
1. **Main Screen**: Displays a list of all contacts.
2. **Add Contact Screen**: Form to add a new contact.
3. **Contact Details Screen**: Shows details of a selected contact with options to edit or delete.

## Requirements
- macOS with **Xcode 14.0** or later
- iOS **15.0** or later
- Swift **5.0** or later
- **Git** (for version control)
- **Cocoapods** (if using any third-party dependencies)

## Installation
To set up this project on your local machine, follow these steps:

### 1. Clone the Repository
First, clone this repository to your local machine using the terminal:
```bash
git clone https://github.com/hrishikasamani/ContactsApp
cd ContactsApp
```

### 2. Open the Project in Xcode
Open Xcode.
Click on File > Open.
Navigate to the cloned repository folder and select the .xcodeproj file:
```bash
open ContactsApp.xcodeproj
```

### 3. Install Dependencies (if using Cocoapods)
If your project uses Cocoapods for dependency management:
```bash
# Install pods
pod install
```
Then, open the .xcworkspace file instead of .xcodeproj:
```bash
open ContactsApp.xcworkspace
```

### 4. Configure Signing & Capabilities
Open the project in Xcode.
Go to the Signing & Capabilities tab.
Select your development team and ensure the bundle identifier is unique.

### 5. Build & Run the Project
Select the target device or simulator (e.g., iPhone 15 Pro).
Press `Cmd + R` or click the Run button to build and run the app.

## Setup

### Step-by-Step Setup Guide

1. **Download Xcode:**
   
   - Ensure you have the latest version of Xcode installed from the Mac App Store.
   
2. **Clone the Repository:**
   
   ```bash
    git clone https://github.com/hrishikasamani/ContactsApp
    cd ContactsApp
   ```
   
3. **Open the Project**

4. **Install Dependencies (If Applicable):**

   - If you're using Cocoapods, run:
     ```bash
     pod install
     ```
     
   - If you're using Swift Package Manager, open the project in Xcode, go to *File > Add Packages* to resolve any dependencies.

5. **Running the App:**
   
   - In Xcode, select a target simulator (e.g., iPhone 15 Pro).
   - Press Cmd + R to build and run the project.

## Usage

- Add a Contact: Tap the + button on the main screen, fill in the details, and tap "Save".
- Edit a Contact: Tap on a contact in the list, click "Edit", modify the details, and tap "Save".
- Delete a Contact: Swipe left on a contact in the list to delete it.
- Profile Picture: If a profile picture is not selected, a default avatar will be used.

## Contact

If you have any questions, feel free to reach out:

- **Hrishika Samani**
- [LinkedIn](https://www.linkedin.com/in/hrishika-samani)
- [Email](mailto:hrishikasamani@gmail.com)
