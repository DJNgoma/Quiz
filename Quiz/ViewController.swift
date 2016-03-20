//
//  ViewController.swift
//  Quiz
//
//  Created by Daliso Ngoma on 14/03/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!

    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?",
                               "What is 7+7?",
                               "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes",
                             "14",
                             "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    // MARK: Display Related Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let question = questions[currentQuestionIndex]
        currentQuestionLabel.text = question
        
        updateOffScreenLabel()
        
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the lables's inital alpha
        nextQuestionLabel.alpha = 0
    }
    
    // MARK: Quiz Related Methods
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    
    func animateLabelTransitions() {
        
        // Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        // Animate the alpha
        // and the center X constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
//        Before Bronze Challenge
//        UIView.animateWithDuration(0.5,
//           delay: 0,
//           options: [.CurveLinear],
//           animations: {
//            self.currentQuestionLabel.alpha = 0
//            self.nextQuestionLabel.alpha = 1
//            
//            self.view.layoutIfNeeded()
//           },
//           completion: { _ in
//                swap(&self.currentQuestionLabel,
//                     &self.nextQuestionLabel)
//                swap(&self.currentQuestionLabelCenterXConstraint,
//                     &self.nextQuestionLabelCenterXConstraint)
//            
//                self.updateOffScreenLabel()
//        })
        
//        After Bronze Challenge
        UIView.animateWithDuration(0.5,
           delay: 0,
           usingSpringWithDamping: 0.8,
           initialSpringVelocity: 0,
           options: [.CurveLinear],
           animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            
            self.view.layoutIfNeeded()
           },
           completion: { _ in
            swap(&self.currentQuestionLabel,
                &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint,
                &self.nextQuestionLabelCenterXConstraint)
            
            self.updateOffScreenLabel()
        })
        
    }
}

