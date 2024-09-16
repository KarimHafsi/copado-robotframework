# NEO On-Premise Automation
This project automates test scripts for NEO Office and Mobile App using the on-premise environment set-up.


## Prerequisites
* macOS (Catalina) 10.15.x or later

* iOS 13.x or later

* Homebrew, Tessaract and ideviceinstaller

* Node.js 10.x or newer and NPM
  
* Python


## Installation
Whole procedure is described on [Confluence](https://pernod-ricard.atlassian.net/l/cp/j1Zx9Y81).


## Usage/Examples
Run tests tagged “tag” of file.robot.

Clone the project

```bash
  git clone https://github.com/pernod-ricard-coe-sales-tech/pr-salestechcoe-copado-robotic-testing.git
```

Add your test ids to secret.robot

```bash
  cd /Users/./pr-salestechcoe-copado-robotic-testing/resources/secret.robot
```


## Running Tests
The project includes unit tests that can be run with the following command:

```bash
  robot -i unitTest tests
```


## Documentation
[Documentation](https://pernod-ricard.atlassian.net/l/cp/f157h359)


## Acknowledgements
- [Robot - NEO On-Premise Automation](https://eu-robotic.copado.com/robots/39563/r/23909)
- [Project - Dashboard](https://eu-robotic.copado.com/robots/39563/dashboard)

Libraries                      
- [QWeb](https://docs.copado.com/resources/Storage/copado-robotic-testing-publication/CRT%20Site/qwords-reference/current/qwords/_attachments/QWeb.html)
- [QMobile](https://docs.copado.com/resources/Storage/copado-robotic-testing-publication/CRT%20Site/qwords-reference/current/qwords/_attachments/QMobile.html)
- [QForce](https://docs.copado.com/resources/Storage/copado-robotic-testing-publication/CRT%20Site/qwords-reference/current/qwords/_attachments/QForce.html)
- [BuiltIn](https://docs.copado.com/resources/Storage/copado-robotic-testing-publication/CRT%20Site/qwords-reference/current/qwords/_attachments/BuiltIn.html)
- [robotframework-retryfailed](https://github.com/MarketSquare/robotframework-retryfailed)

## Contributing

### Indentation
Every file has to be auto indented. 

#### Shortcut:
Windows `Shift + Alt + F`

Mac `Shift + Option + F`

Ubuntu `Ctrl + Shift + I`

### Element
Elements should always be contained in a variable, every elements are on top of the file in the section Variables. By convention, variable names will be composed of lowercase letters with underscores.

`${my_element}  //beautiful[@name=variable]`

### Tasks ### 
*** Tasks ***
`Insert the new employee into the HR system`

### Keywords ### 
*** Keywords ***
`Open the HR application`

### Summary ### 
Naming is important. Naming is also hard.

* Use business terminology in your code. It helps in understanding the problem.
* Use descriptive names for keywords, arguments, variables.
* Aim to make your code self-documenting. Rely less on external documentation, since it might get out-of-sync.
* Use comments when they provide value and when the code cannot communicate the "why".
* Investing in good naming will pay dividends, and your fellow developers will thank you for taking the effort to make their (and your) life easier!


## Feedback
If you have any feedback, please reach out to me at karim.hafsi-ext@pernod-ricard.com