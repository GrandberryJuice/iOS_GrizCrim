//
//  AboutUsVC.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 11/19/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import MessageUI

class AboutUsVC: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func BackBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
    // MARK: Report users
    @IBAction func ReportUser(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let reportAction = UIAlertAction(title: "Report", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.sendEmail()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(reportAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func sendEmail()  {
        var mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        if MFMailComposeViewController.canSendMail() {
            mailComposerVC = configureMailComposeViewController()
            self.present(mailComposerVC, animated:true,completion:nil)
            
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        //configure email info
        mailComposerVC.setToRecipients(["nerdinabriefcase@yahoo.com"])
        mailComposerVC.setSubject("Sending an email about a report")
        mailComposerVC.setMessageBody("Sending e-mail in-app", isHTML: false)
        
        return mailComposerVC
    }
    
    //MARK: Show email error message
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title:"Could not send email", message:"Your device could not send e-mail. Please check email configuration and try again.", delegate: self, cancelButtonTitle:"OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController!, didFinishWith result:MFMailComposeResult, error: Error!) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}
