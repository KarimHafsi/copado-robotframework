*** Settings ***
Resource                        ../resources/web.robot
Suite Setup                     Start Suite
Suite Teardown                  End Suite

*** Test Cases ***
Check Schedule Page UI Elements
    [Documentation]             Checking UI Elements for Schedule Page
    [Tags]                      NEO-10168                   UI
    Appstate                    Home
    Navigate To Page            VISIT_SCHEDULE
    VerifyPage                  VISIT_SCHEDULE
    ClickText                   Avec weekend
    VerifyAll                   Samedi, Dimanche
    ClickText                   Sans weekend
    VerifyNoText                Samedi
    VerifyNoText                Dimanche


Unprepare And Clean Visits From Calendar Schedule Page
    [Documentation]             As an authentified CDS, unprepare and clean every visit from the calendar
    [Tags]                      NEO-10243                   NEO-10244                   E2E_VISIT-HBP       E2E_VISIT-BP
    Appstate                    Home
    Navigate To Page            VISIT_SCHEDULE
    Unprepare Visit From Calendar
    Remove Visit From Calendar


Schedule Visit from Business Plan Recommandations
    [Documentation]             As an authentified CDS, schedule a visit from Business Recommandations List
    [Tags]                      NEO-10170                   E2E_VISIT-BP
    Appstate                    Home
    Navigate To Page            VISIT_SCHEDULE
    ClickText                   Sem                         #to open dropdown
    ClickElement                ${week_filter_dropdown_list}                            index=1             #select "empty".
    ClickElement                ${filter_button}
    Sleep                       1
    ${is_visit_with_BP_visit_goal_available}=               IsElement                   ${column_visit_name_first_BP_visit_goal_visit}
    Set Global Variable         ${is_visit_with_BP_visit_goal_available}

    IF                          ${is_visit_with_BP_visit_goal_available}
        ${BP_visit_name}=       GetText                     ${column_visit_name_first_BP_visit_goal_visit}
        Set Global Variable     ${BP_visit_name}
        Log To Report And Console                           BP_visit_name               ${BP_visit_name}

        ${BP_visit_address}=    GetText                     ${column_visit_address_first_BP_visit_goal_visit}
        Set Global Variable     ${BP_visit_address}
        Log To Report And Console                           BP_visit_address            ${BP_visit_address}

        Scroll And Drag Drop    ${current_time_indicator}                               ${line_first_BP_visit_goal_visit}    40    3s
        Sleep                   2
        VerifyNoText            Loading
        #VerifyText             ${BP_visit_name} - ${BP_visit_address}
        Set Global Variable     ${is_BP_visit_planned}      True
    ELSE
        Pass Execution          No BP visit available with main Objective "${BP_visit_goal}". Try running your command with "-v BP_visit_goal:[insert_visit_goal]"
    END


Schedule Visit from Non Business Plan Recommandations
    [Documentation]             As an authentified CDS, schedule a visit from Hors Business Recommandations List
    [Tags]                      NEO-10216                   E2E_VISIT-HBP
    Appstate                    Home
    Navigate To Page            VISIT_SCHEDULE
    VerifyText                  Visites Hors BP
    ClickText                   Visites Hors BP
    VerifyText                  Vendredi
    ClickElement                ${filter_button_visite_HBP}
    ClickElement                ${filter_option_circuit}
    Add Option To Filter        HM+
    Add Option To Filter        HM-
    Add Option To Filter        SM+
    Add Option To Filter        SM-
    ClickElement                ${close_filter_button}
    ClickElement                ${apply_filter_button}
    Scroll and Drag Drop HBP    ${current_time_indicator}                               ${visit_to_plan}    40              3s
    #ToDo: get ${HBP_visit_name} and ${HBP_visit_address} dynamically
    Sleep                       2
    Set Global Variable         ${is_HBP_visit_planned}     True
    #VerifyText                 ${HBP_visit_name} - ${HBP_visit_address}