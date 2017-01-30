# Scrolling without UIScrollView

Despite having a class called [UIScrollView](https://developer.apple.com/reference/uikit/uiscrollview) for this purpose, i saw this [question](http://es.stackoverflow.com/questions/4517/scrollview-sin-usar-uiscrolview) on Stackoverflow and I thought how I could solve this on a different way.

Well, the first solution I thought (maybe not the best) was using a **View** and add it the **PanGestureRecognizer** in order to capture the user's touches. So I started to code:

	import UIKit

	class ViewController: UIViewController {

    	@IBOutlet weak var scrollView: UIView!
    	
		override func viewDidLoad() {
        	super.viewDidLoad()
        	addPanGesture()
    	}
    
    	func addPanGesture() {
        	let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didScroll))
        	self.scrollView.addGestureRecognizer(panGesture)
    	}
    	
    	func didScroll(sender : UIPanGestureRecognizer) {
    		if sender.state == .recognized {
            
            let translation = sender.translation(in: self.scrollView).y
            let y = self.scrollView.frame.origin.y
            let scrollViewSize = self.scrollView.frame.size.height
            let viewSize = self.view.frame.size.height
            var newY = y + translation
            
            // These conditions avoids scrollView to leave the screen
            
            if newY > 0 {
                newY = 0
            } else if newY + scrollViewSize <  viewSize {
                newY = -scrollViewSize + viewSize
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.scrollView.frame = CGRect(x: 0,
                                            y: newY,
                                            width: self.scrollView.frame.width,
                                            height: scrollViewSize)
             })
        }

		}
		
**Do not forget to connect the** `IBOutlet` **with the UIView on the XIB or Storyboard!!**

## didScroll method

First of all, we ensure that it is the 'Pan' gesture with: 

`sender.state == .recognized`

After we have recognized it, we declare some useful variables to store information about our scrollView, superView and pan gesture.
            
    let translation = sender.translation(in: self.scrollView).y
    let y = self.scrollView.frame.origin.y
    let scrollViewSize = self.scrollView.frame.size.height
    let viewSize = self.view.frame.size.height
    var newY = y + translation
       
One problem we have is that scrollView may disappear at the top and at the bottom of the screen. So that we avoid this, we have to check the future position of our scrollView.

	// These conditions avoids scrollView to leave the screen
            
    if newY > 0 {
        newY = 0
    } else if newY + scrollViewSize <  viewSize {
        newY = -scrollViewSize + viewSize
    }

After that, we can animate the scrollView to simulate the scroll, like this:
		
	UIView.animate(withDuration: 0.5, animations: {
                
        self.scrollView.frame = CGRect(x: 0,
                                       y: newY,
                                       width: self.scrollView.frame.width,
                                       height: scrollViewSize)
    })
    
It can be easily improve, but this code was implemented for simply curiosity, how could I solve this? That was the first thing on my mind.
