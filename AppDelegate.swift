/*
To run the code:
swiftc -o StatusMenuApp AppDelegate.swift -framework AppKit
./StatusMenuApp

*/

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Set up the status bar item with a system symbol icon
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "star.fill", accessibilityDescription: "Status Menu")
            button.image?.isTemplate = true // Adapts to light/dark mode
        }

        // Create the menu
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Run Program", action: #selector(runProductivityScript), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        statusItem?.menu = menu
    }

    @objc func runProductivityScript() {
        // Run productivity.py script located in the same repository folder
        let fileManager = FileManager.default
        let appPath = fileManager.currentDirectoryPath
        let scriptPath = "\(appPath)/productivity.py" // Assuming productivity.py is in the same repo folder

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/Users/dowrion/Desktop/CSE/CSE108/Project/.venv/bin/python3") // Path to python3
        process.arguments = [scriptPath]

        do {
            try process.run()
            process.waitUntilExit() // Waits until the script completes
        } catch {
            print("Failed to run script: \(error)")
        }
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(self)
    }
}

// Explicit entry point
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
