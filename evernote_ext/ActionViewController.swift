//
//  ActionViewController.swift
//  evernote_ext
//
//  Created by Damian on 2/21/15.
//  Copyright (c) 2015 Damian. All rights reserved.
//

import UIKit
import MobileCoreServices
import UIView

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    func shouldAutorotate(imageView) -> Bool
    
    func becomeFirstResponder() -> Bool {
        var nibName: String? { MainInterface } //get has property?
        var extensionContext: NSExtensionContext? { get }
        var inputViewController: UIInputViewController? { get }

        }
    
    func constraints() -> [imageView] {
        //constraints woudl be limited to just half of the screen.
    
    }

    
    
    func loadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        for item: AnyObject in self.extensionContext!.inputItems {
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakImageView = self.imageView
                    itemProvider.loadItemForTypeIdentifier(kUTTypeImage as String, options: nil, completionHandler: { (image, error) in
                        if image != nil {
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                if let imageView = weakImageView {
                                    imageView.image = image as? UIImage
                                }
                            }
                        }
                    })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }

}
