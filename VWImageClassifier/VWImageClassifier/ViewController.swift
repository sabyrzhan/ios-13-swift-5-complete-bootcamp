//
//  ViewController.swift
//  VWImageClassifier
//
//  Created by Sabyrzhan Tynybayev on 2/3/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    let uiPickerContoller = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiPickerContoller.delegate   = self
        uiPickerContoller.sourceType = .camera
        uiPickerContoller.allowsEditing = false
    }

    @IBAction func takePhotoClicked(_ sender: UIBarButtonItem) {
        present(uiPickerContoller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            guard let ciImage = CIImage(image: pickedImage) else {
                fatalError("Could not create CIImage from picked image")
            }
            
            detect(ciImage: ciImage)
            
        }
        
        uiPickerContoller.dismiss(animated: true, completion: nil)
    }
    
    func detect(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: VWImageClassifier.init(configuration: MLModelConfiguration()).model) else {
            fatalError("Error loading VWImageClassifier model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, model) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Error getting results from request")
            }
            
            guard let firstResult = results.first else {
                fatalError("Error getting first result from results")
            }
            
            let title = firstResult.identifier
            
            self.label.text = title
            
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("\(error)")
        }
    }
}

