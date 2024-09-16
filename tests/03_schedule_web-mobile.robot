*** Settings ***
Resource                        ../resources/web.robot
Suite Setup                     Start Suite Mobile
Suite Teardown                  End Suite Mobile

*** Test Cases ***
Login to NEO Office from Safari mobile browser
    [Documentation]             As an authenticated CDS, I can access NEO Office
    [Tags]                      NEO-9810                    LOGIN
    Appstate                    Home


Prepare Visit from Business Plan Recommandations
    [Documentation]             As an authentified CDS, prepare a visit from Business Recommandations List
    [Tags]                      NEO-10217                   E2E_VISIT-BP
    Appstate                    Home
    Navigate To Page            VISIT_SCHEDULE
    Sleep                       2

    ${BP_visit_title}           Set Variable                ${BP_visit_name} - ${BP_visit_address}
    Log to Console              BP_visit_title is now: ${BP_visit_title}

    Check If BP Visit Has Been Planned And Click Visit      ${BP_visit_title}

    Log To Console              "BP_visit_name" was: ${BP_visit_name}
    ${element_text}             Get Text                    ${visit_title_header}
    Set Global Variable         ${BP_visit_name}            ${element_text}
    Log To Report And Console                               BP_visit_name               ${BP_visit_name}

    ${BP_visit_type_displayed}                              GetText                     ${visit_type_header}
    Set Global Variable         ${BP_visit_type_displayed}
    Log To Report And Console                               visit_type_displayed        ${BP_visit_type_displayed}

    VerifyText                  Enregistrer
    VerifyElement               ${checkbox_prepared_unchecked}                          #Préparée unchecked

    Prepare BP Visit Priority Action
    Prepare Visit Other Tasks
    VerifyElement               ${checkbox_prepared_checked}                            #Préparée checked


Prepare Visit from Hors Business Plan Recommandations
    [Documentation]             As an authentified CDS, prepare a visit from Non Business Recommandations List
    [Tags]                      NEO-10218                   E2E_VISIT-HBP
    Appstate                    Home
    Navigate To Page            VISIT_SCHEDULE
    Sleep                       2

    Check If HBP Visit Has Been Planned And Click Visit     ${HBP_visit_name}

    Log To Console              "HBP_visit_name" was: ${HBP_visit_name}
    ${element_text}             Get Text                    ${visit_title_header}
    Set Global Variable         ${HBP_visit_name}           ${element_text}
    Log To Report And Console                               HBP_visit_name              ${HBP_visit_name}

    ${HBP_visit_type_displayed}                             GetText                     ${visit_type_header}
    Set Global Variable         ${HBP_visit_type_displayed}
    Log To Report And Console                               HBP_visit_type_displayed    ${HBP_visit_type_displayed}

    VerifyText                  Enregistrer
    VerifyElement               ${checkbox_prepared_unchecked}                          #Préparée unchecked

    Prepare Visit Other Tasks
    VerifyElement               ${checkbox_prepared_checked}                            #Préparée checked