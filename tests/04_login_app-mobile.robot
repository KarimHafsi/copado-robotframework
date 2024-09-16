*** Settings ***
Resource                        ../resources/app.robot
Suite Setup                     Start Suite Mobile
Suite Teardown                  End Suite Mobile

*** Test Cases ***
Check Login Page UI Elements
    [Documentation]             Checking UI Elements for Login Page
    [Tags]                      NEO-10219                   UI
    Login Page
    VerifyPage                  LOGIN

    ${is_remember_me_checked_before}                        GetValue                    xpath\=${remember_me_checkbox}             value
    ClickElement                ${remember_me_checkbox}
    ${is_remember_me_checked_after}                         GetValue                    xpath\=${remember_me_checkbox}             value
    Should Not Be Equal         ${is_remember_me_checked_before}                        ${is_remember_me_checked_after}

    Click Field And Fill Value                              ${login_username_field}     automation.test@pernod-ricard.com
    Click Field And Fill Value                              ${login_password_field}     1234567POIUYTRE?./$&é"'§è!çà%%£


Check Password recovery Page UI Elements
    [Documentation]             Checking UI Elements for Password recovery Page
    [Tags]                      NEO-10220                   UI
    Login Page

    ${is_touch_id_popup_displayed}                          IsText                      Touch ID
    Run Keyword If              ${is_touch_id_popup_displayed}                          ClickText                   Cancel

    ClickText                   Forgot Your Password?
    VerifyPage                  PASSWORD_RECOVERY
    ClickText                   Cancel
    VerifyPage                  LOGIN


Login to NEO Mobile application from iOS device
    [Documentation]             As an authenticated CDS, I can access NEO Mobile application from iOS device
    [Tags]                      NEO-10251                   LOGIN
    Login Page
    Home


Synchronise the application data
    [Documentation]             As an authentified CDS, synchronise the application data
    [Tags]                      NEO-10221                   E2E_VISIT-HBP               E2E_VISIT-BP
    Home

    Synch App Data
    ${is_a_visit_in_progress}                               Run Keyword And Return Status                           VerifyElement           ${visit_in_progress_error_message}    timeout=5

    IF                          ${is_a_visit_in_progress}
        ClickElement            ${confirmation_button}
        Log Out
        Log In
        Synch App Data
    END

    ${is_success_displayed}=    Run Keyword And Return Status                           VerifyText                  Succès         timeout=300    #5min

    WHILE                       ${is_success_displayed}
        ClickElement            ${confirmation_button_synch}
        ${is_success_displayed}=                            Run Keyword And Return Status                           VerifyText     Succès
    END

    VerifyNoText                Succès