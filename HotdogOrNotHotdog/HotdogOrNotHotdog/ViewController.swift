//
//  ViewController.swift
//  HotdogOrNotHotdog
//
//  Created by Sabyrzhan Tynybayev on 1/17/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let uiPickerContoller = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiPickerContoller.delegate   = self
        uiPickerContoller.sourceType = .camera
        uiPickerContoller.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickerImage
            
            guard let ciImage = CIImage(image: userPickerImage) else {
                fatalError("Could not create CIImage")
            }
            
            detect(ciImage: ciImage)
        }
        
        uiPickerContoller.dismiss(animated: true, completion: nil)
    }
    
    func detect(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: MobileNetV2.init(configuration: MLModelConfiguration()).model) else {
            fatalError("Loading CoreML model failed.")
        }
        
        let request = VNCoreMLRequest(model: model) {(request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            guard let firstResult = results.first else {
                fatalError("First result fetch failed")
            }
            
            if firstResult.identifier.contains("hotdog") {
                self.navigationItem.title = "Hotdog"
            } else {
                self.navigationItem.title = "Not hotdog"
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("\(error)")
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(uiPickerContoller, animated: true, completion: nil)
    }
}

