//
//  PhotoSelectViewController.swift
//  Instagram
//
//  Created by Stephon Fonrose on 12/10/18.
//  Copyright © 2018 Stephon Fonrose. All rights reserved.
//

import UIKit

class PhotoSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageSelectorPhoto: UIImageView!
    @IBOutlet weak var imageCaption: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageSelectorPhoto.isUserInteractionEnabled = true
    }
    @IBAction func onPhotoSelect(_ sender: Any) {
        self.takeImage()
    }
    @IBAction func onPhotoLibrary(_ sender: Any) {
        self.chooseImage()
    }
    
    func takeImage() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func chooseImage() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        guard let editedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imageSelectorPhoto.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "composeToHomeSegue", sender: nil)
    }
    
    @IBAction func onShare(_ sender: Any) {
        Post.postUserImage(image: imageSelectorPhoto.image, withCaption: imageCaption.text) {( success: Bool, error: Error?) in
        if success {
            print("Post Success")
        } else {
            print("Posting error: \(error!.localizedDescription)")
        }
        }
        self.performSegue(withIdentifier: "composeToHomeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let vc = nav.topViewController as! HomeFeedViewController
        vc.didActionHappen = true
    }
}
