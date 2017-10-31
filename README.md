# MarkDownKit

[![CI Status](http://img.shields.io/travis/AssafYehudai/MarkDownKit.svg?style=flat)](https://travis-ci.org/AssafYehudai/MarkDownKit)
[![Version](https://img.shields.io/cocoapods/v/MarkDownKit.svg?style=flat)](http://cocoapods.org/pods/MarkDownKit)
[![License](https://img.shields.io/cocoapods/l/MarkDownKit.svg?style=flat)](http://cocoapods.org/pods/MarkDownKit)
[![Platform](https://img.shields.io/cocoapods/p/MarkDownKit.svg?style=flat)](http://cocoapods.org/pods/MarkDownKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MarkDownKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ChatyMarkDownKit', '~>0.1.6'
```

## Author

AssafYehudai, assaf.yehudai@gmail.com

## License

MarkDownKit is available under the MIT license. See the LICENSE file for more info.

## Example code 
```
let TEXT = "`*_Lorem ipsum dolor_* sit er elit lamet, consectetaur *cillium adipisicing pecu, *sed` do eiusmod tempor incididunt ut
             labore et dolore magna aliqua. Ut enim ad minim veniam,*quis nostrud* exercitation ullamco laboris nisi `ut aliquip
             exea commodo consequat.` Duis aute irure *dolor in _reprehenderit* in voluptate_ velit esse cillum dolore eu fugiat
             null pariatur.~Excepteur sint occaecat~ cupidatat non proident, _sunt in culpa_ qui officia deserunt mollit anim id
             est laborum. Nam liber te *conscient to factor* tum poen legum odioque civiuda."

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var attributesButton: UIButton!
    let fontSize = CGFloat(16)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = TEXT
        textView.font = UIFont.systemFont(ofSize: fontSize)
    }

    // MARK: - IBActions

    @IBAction func SetAttributesTapped(_ sender: UIButton) {

        textView.attributedText = MarkDown(string: TEXT, fontsSize: fontSize).markDown()
    }
}
```
