//
//  NotesViewController.swift
//  ToDoIt
//
//  Created by Richard Balabarcon on 9/25/20.
//  Copyright © 2020 Richard Balabarcon. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class NotesViewController: UIViewController, UITextViewDelegate {
    
    var noteItems: Results<Notes>?

    @IBOutlet weak var notePad: UITextView!
    
    let realm = try! Realm()
    
    var selectedItem : Item? {
        didSet {
            
 //           loadNotes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let containerSize = CGSize(width: self.view.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true

        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(container)

//        let storage = Storage()
//        let theme = Theme("one-dark")
//        storage.theme = theme
//        storage.addLayoutManager(layoutManager)
//
//        let editor = UITextView(frame: self.view.bounds, textContainer: container)
//        editor.backgroundColor = theme.backgroundColor
//        editor.tintColor = theme.tintColor
//        editor.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
    }
    
    //MARK - TextView Data Source Methods
    
  //  override func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
     
        
        func loadNotes() {
            
            noteItems = selectedItem?.notes.sorted(byKeyPath: "title", ascending: true)

     //       textView.reloadData()

            }
        
    }
    
