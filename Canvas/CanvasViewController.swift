//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Hannah Peckham on 2/17/16.
//  Copyright © 2016 Hannah Peckham. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
//adaasdasdfasdffds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)

    }

    
    
    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        
        
        if sender.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
        
        } else if sender.state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
            
        } else if sender.state == UIGestureRecognizerState.Ended{
            if velocity.y > 0 {
                // Tray moving down
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.trayView.center = self.trayDown
                })
            } else {
                // tray moving up
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.trayView.center = self.trayUp
                })
                
            }
        }
    }
    
    
    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
            panGestureRecognizer.delegate = self
            
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(2.5, 2.5)
            })
            
            
        } else if sender.state == UIGestureRecognizerState.Changed{
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == UIGestureRecognizerState.Ended{
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformIdentity
            })

            
        }
        
        
    }
    
    
    func onCustomPan (sender: UIPanGestureRecognizer){
        let translation = sender.translationInView(view)
    
        if sender.state == UIGestureRecognizerState.Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(2.5, 2.5)
            })
            
            var pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "didPinchNewFace:")
            pinchGestureRecognizer.delegate = self
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            
            var rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: "didRotate:")
            rotationGestureRecognizer.delegate = self
            newlyCreatedFace.addGestureRecognizer(rotationGestureRecognizer)

            
        } else if sender.state == UIGestureRecognizerState.Changed{
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == UIGestureRecognizerState.Ended{
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformIdentity
            })

            
        }

        
    }
    
    func didPinchNewFace (sender: UIPinchGestureRecognizer){
        let scale = sender.scale
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed{
            print(scale)
            self.newlyCreatedFace.transform = CGAffineTransformMakeScale(scale, scale)
            
        } else if sender.state == UIGestureRecognizerState.Ended{
            
        }

    }
    
    func didRotate (sender: UIRotationGestureRecognizer){
        let rotation = sender.rotation
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed{
            self.newlyCreatedFace.transform = CGAffineTransformRotate(newlyCreatedFace.transform, rotation)
            
        } else if sender.state == UIGestureRecognizerState.Ended{
            
        }

    }
    
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
