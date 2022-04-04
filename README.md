# MVCtoMVVM
A simple app that displays the number of birds sighted at a locaton in the UK. Created tto identify the differences between the design patterns- MVC and MVVM. Uses the ebird api. If there are more than 5 birds the cell accessory type and label changes, this functionality sits in different files depending on the design pattern.

## **Branches:**
### Main 
This branch contains MVC and MVVM patterns, switch between them by editing the app and scene delegate (comment/uncomment to select desired pattern)

### Original Code
This branch is the orginal code from the youtube tutorial I followed. (LINK)
It has both MVC and MVVM in the same project, *change the app and scene delegate to switch from between the two.*
Shows different code particularly programatic UI things I could look into, e.g: 
    
    - Custom navigation controller 
    - tableview highlight - override func setHighlighted (when you hold down on the simulator )
    - table view seperator colour and inset - tableView.separatorInset
    - table view height
    - nav bar set up in controller - navigationController?.navigationBar.isTranslucent = false
    - UIColor custom extension to make adding r,g,b colours quicker, not really neccessary 

###  MVC IB + MVVM IB
At present I am more familiar with using interface bulider so converted the storyboard so that I could focus on the different design patterns 

### Improvements/Todo
- The detail labels truncate, need to make the cells dynamic so the height changes.  
- Dealing with the optional 'HowMany' from the api better
- Hide api key
- Could add IB branches together, just have both in storyboard and change the intial controller when switching patterns
- Investigate MVCvsMVVM tutorial to see differences e.g static cell identifier





