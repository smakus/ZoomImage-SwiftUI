# ZoomImage-SwiftUI
A basic pinch-to-zoom image view for swiftUI

You can use this SwiftUI View to display an image at the proper aspect, zoomed in to default width or height of the screen, depending on image aspect.  Then you can pinch to zoom and swipe to move around the image.

Usage is self-explanatory... just put this in a .sheet, or navigationView as needed.  All you need to pass in is the UIImage you want to display.

THERE ARE TWO VERSIONS of the pinch to zoom view.  One uses pure swiftUI, the other utilizes PDFKit (Apple's built-in library) for better pinch + scroll support. One day i hope to improve the pure swiftUI version, but for now simultaneous/multiple gesture support seems janky when it comes to pinch + scroll, so for now this primative swiftui version is left here.
