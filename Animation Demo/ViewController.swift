//
//  ViewController.swift
//  Animation Demo
//
//  Created by Andrew Jaffee on 1/7/17.
//
/*
 
 Copyright (c) 2017 Andrew L. Jaffee, microIT Infrastructure, LLC, and
 iosbrain.com.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

import UIKit

class ViewController: UIViewController
{
    
    // our main drawing view ("canvas" if you like); this is the
    // one we created in the storyboard
    @IBOutlet weak var mainSubView: UIView!
    
    // the view we'll animate; to keep the code simple, I'm
    // forcibly unwrapping this view instead of using an optional or
    // creating an init for the UIViewController
    var animateView: UIView!
    
    // to make the animatable view look nice, we offset it
    // from the main canvas view
    let animateViewMarginToMain: CGFloat = 10.0
    
    // this is the initial width and height of the
    // view we'll animate; initially, it is relatively small compared
    // to the canvas view
    let animateViewWidth: CGFloat = 50.0
    let animateViewHeight: CGFloat = 50.0
    
    // instantiate the variables that will define a
    // new width and height for the subview we'll animate
    var animateViewNewWidth: CGFloat = 0.0
    var animateViewNewHeight: CGFloat = 0.0
    
    // MARK: - User interactions
    
    /** When the user taps the "Animate" button, we... animate the
     initially small view that we added to the canvas view in
     viewDidLoad
     */
    @IBAction func animateButtonTapped(_ sender: Any)
    {
        
        // I want the initially small view to grow until it almost fills
        // the canvas view; I keep the margins of the subview the same
        // on top, bottom, right, and left.
        animateViewNewWidth = mainSubView.bounds.width - animateViewMarginToMain*2.0
        animateViewNewHeight = mainSubView.bounds.height - animateViewMarginToMain*2.0
        
        // display the calculation for making the subview grow but staying
        // within the canvas view, with a nice consistent margin
        print("animateViewNewHeight/Width: \(mainSubView.bounds.width) - \(animateViewMarginToMain*2.0) = \(animateViewNewWidth)")
        
        // show the bounds and frame of the canvas view and animatable subview
        // BEFORE the animation
        printCGRects()
        
        // "Animate changes to one or more views using the specified
        // duration, delay, options, and completion handler."
        UIView.animate(withDuration: 2.0, delay: 2.0, options: UIViewAnimationOptions.curveEaseIn, animations:
            {
                // This is the FIRST animation. This will make the subview
                // appear -- fading into visual appearance
                self.animateView.alpha = 1.0
        })
        { (completed:Bool) in // This block is executed after the FIRST animation completes.
            if (completed) // Only proceed if the FIRST animation succeeds.
            {
                // This is the SECOND animation block.
                UIView.animate(withDuration: 2.0)
                {
                    // According to Apple, the frame is one of the "Animatable UIView properties"
                    // and we can "Modify this property to change the view’s size and position
                    // relative to its superview’s coordinate system."
                    self.animateView.frame.size.width = self.animateViewNewWidth
                    self.animateView.frame.size.height = self.animateViewNewHeight
                    
                    // show the bounds and frame of the canvas view and animatable subview
                    // AFTER the animation
                    self.printCGRects()
                }
            } // end if
        } // end completion block
        
    } // end func animateButtonTapped
    
    // MARK: - UIViewController delegate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Create a subview in our main drawing view on app startup
        configureAnimateView()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
    } // end func viewDidAppear
    
    // MARK: - Subview setup
    
    /**
     Create a subview in our main drawing view;
     initially, hide the subview
     */
    func configureAnimateView () -> Void
    {
        // Create the CGRect which defines the geometry of the subview to animate
        // DO I NEED TO ADD THE mainSubView.bounds.origin.x AND y HERE???
        let animateViewRect = CGRect(x: animateViewMarginToMain + mainSubView.bounds.origin.x,
                                     y: animateViewMarginToMain + mainSubView.bounds.origin.y,
                                     width: animateViewWidth,
                                     height: animateViewHeight)
        
        // Create the subview based on the CGRect
        animateView = UIView(frame: animateViewRect)
        
        // Make the subview red so it is easily identifiable in animation
        animateView.backgroundColor = UIColor.red
        
        // Initially hide the subview so that we can animate it
        // onto the main canvas view
        animateView.alpha = 0.0
        
        // WE MUST add the new subview to the main canvas view
        mainSubView.addSubview(animateView)
        
    } // end func configureAnimateView
    
    // MARK: - Helper method(s)
    
    /**
     Display bounds and frame definitions for views we're working with
     */
    func printCGRects() -> Void
    {
        print("----------------------------------------")
        print("mainSubView frame: \(mainSubView.frame)")
        print("mainSubView bounds: \(mainSubView.bounds)")
        print("animateView frame: \(animateView.frame)")
        print("animateView bounds: \(animateView.bounds)")
        print("----------------------------------------")
    }
    
    /**
     Remove all subviews from main drawing/animation view
     */
    func removeSubviews() -> Void
    {
        for subView in mainSubView.subviews
        {
            subView.removeFromSuperview()
        }
    }
    
} // end class ViewController
