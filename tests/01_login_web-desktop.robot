*** Settings ***
Resource                ../resources/web.robot
Suite Setup             Start Suite
Suite Teardown          End Suite

*** Test Cases ***
Check Login Page UI Elements
    [Documentation]     Checking UI Elements for Login Page
    [Tags]              NEO-10212                 UI
    Navigate To Page    HOME
    Sleep               2
    VerifyPage          LOGIN
    ClickCheckbox       Remember me               on
    TypeText            Username                  Username
    TypeText            Password                  Password


Check Password recovery Page UI Elements
    [Documentation]     Checking UI Elements for Password recovery Page
    [Tags]              NEO-10213                 UI
    Navigate To Page    HOME
    ClickText           Forgot Your Password?
    VerifyPage          PASSWORD_RECOVERY
    ClickText           Cancel
    VerifyPage          LOGIN


Login to NEO Office from Safari desktop browser
    [Documentation]     As an authenticated CDS, I can access NEO Office
    [Tags]              NEO-9810                  LOGIN
    Appstate            Home


    #Behavior to define
    # Login SSO
    #                   [Documentation]           Login with SSO
    #                   [Tags]                    NEO-10214          UI
    #                   GoTo                      ${base_url}
    #                   ClickText                 Log in with Pernod Ricard SSO
    #                   Sleep                     2
    #                   VerifyElement             ${action_buttons}
    #                   Log out