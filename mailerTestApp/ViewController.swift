//
//  ViewController.swift
//  mailerTestApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/02/16.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!

    let kaoImage = UIImage(named: "kao")!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, let content = contentTextField.text else {
            return
        }

        if !MFMailComposeViewController.canSendMail() {
            print("mailer error")
            return
        }

        let mailComposeVC = MFMailComposeViewController()

        mailComposeVC.mailComposeDelegate = self

        mailComposeVC.setSubject(title)
        mailComposeVC.setToRecipients(["abc@example.com"])
        mailComposeVC.setCcRecipients(["def@example.com", "ghi@example.com"])
        mailComposeVC.setBccRecipients(["jkl@example.com"])
        mailComposeVC.setMessageBody(content, isHTML: false)
        mailComposeVC.addAttachmentData(UIImagePNGRepresentation(kaoImage)!, mimeType: "image/png", fileName: "kao")
        mailComposeVC.setPreferredSendingEmailAddress("shizuna.itoh@gmail.com")

        present(mailComposeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            stateLabel.text = "キャンセル"
        case .saved:
            stateLabel.text = "保存"
        case .failed:
            stateLabel.text = "失敗"
        case .sent:
            stateLabel.text = "成功"
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

