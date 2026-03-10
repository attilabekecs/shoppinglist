import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewControllerRepresentable {

    var completion: (String) -> Void

    func makeUIViewController(context: Context) -> ScannerController {

        let controller = ScannerController()
        controller.completion = completion

        return controller
    }

    func updateUIViewController(_ uiViewController: ScannerController, context: Context) {}
}
