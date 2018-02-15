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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        contentLabel.text = ""
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

        mailComposeVC.setToRecipients(["abc@example.com"])
        mailComposeVC.setSubject(title)
        mailComposeVC.setMessageBody(content, isHTML: false)

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

