import Cocoa
import WebKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var webView: WKWebView!

    func applicationDidFinishLaunching(_ notification: Notification) {

        // Make the application appear normally in the Dock and on screen
        NSApp.setActivationPolicy(.regular)

        // Create WebView
        let configuration = WKWebViewConfiguration()

        webView = WKWebView(
            frame: NSRect(
                x: 0,
                y: 0,
                width: 1280,
                height: 820
            ),
            configuration: configuration
        )

        // Create application window
        window = NSWindow(
            contentRect: NSRect(
                x: 0,
                y: 0,
                width: 1280,
                height: 820
            ),
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable
            ],
            backing: .buffered,
            defer: false
        )

        // Window settings
        window.title = "صقر للمبيعات والمخازن"
        window.center()

        // Put WebView inside the window
        window.contentView = webView

        webView.frame = window.contentView!.bounds
        webView.autoresizingMask = [
            .width,
            .height
        ]

        // Show window
        window.makeKeyAndOrderFront(nil)

        // Bring application to front
        NSApp.activate(ignoringOtherApps: true)

        // Load the HTML interface
        if let url = Bundle.main.url(
            forResource: "index",
            withExtension: "html",
            subdirectory: "Resources"
        ) {
            webView.loadFileURL(
                url,
                allowingReadAccessTo: url.deletingLastPathComponent()
            )
        } else {
            // Show an error if index.html is missing
            let errorHTML = """
            <!DOCTYPE html>
            <html lang="ar" dir="rtl">
            <head>
                <meta charset="UTF-8">
                <style>
                    body {
                        font-family: -apple-system, BlinkMacSystemFont, sans-serif;
                        padding: 40px;
                        direction: rtl;
                    }
                    h1 {
                        color: #8b1e4b;
                    }
                </style>
            </head>
            <body>
                <h1>صقر للمبيعات والمخازن</h1>
                <p>تعذر العثور على ملف واجهة البرنامج index.html.</p>
            </body>
            </html>
            """

            webView.loadHTMLString(
                errorHTML,
                baseURL: nil
            )
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(
        _ sender: NSApplication
    ) -> Bool {
        return true
    }
}
