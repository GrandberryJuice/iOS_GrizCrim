import UIKit
import paper_onboarding

class OnboardingVC: UIViewController {
    
    //MARK: Class not being used as of yet!!
    @IBOutlet weak var onboarding: PaperOnboarding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //skipButton.isHidden = true
        
        // Uncomment next line to setup `PaperOnboarding` from code
        // setupPaperOnboardingView()
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 1)
        
        let titleFont = UIFont(name:"HelveticaNeue-Bold", size:24)!
        let descriptionFont = UIFont(name:"HelveticaNeue", size:18)!
        
        return [
            ("man-threating-with-his-fist", "Speak a different language?", "Make money by connecting with others in need of your skills! ", "", backgroundColorOne, UIColor.white, UIColor.white, titleFont, descriptionFont),
            
            ("mapOnboarding", "Need a translator or interpreter?", "Search here and find individuals that speak the language you need and can offer their services.", "", backgroundColorTwo, UIColor.white, UIColor.white, titleFont, descriptionFont),
            
            ("mapOnboarding", "Communicate! ", "Use the in-app chat feature to connect and message each other about job opportunities!", "", backgroundColorThree, UIColor.white, UIColor.white, titleFont, descriptionFont)
            ][index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {}
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 1 {
            //if self.getStartedBtn.alpha == 1 {
                
                //UIView.animate(withDuration: 0.2, animations: {
                 //   self.getStartedBtn.alpha = 0
               // })
            //}
        }
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 2 {
           // UIView.animate(withDuration: 0.4, animations: {
             //   self.getStartedBtn.alpha = 1
           // })
        }
    }
    
}
