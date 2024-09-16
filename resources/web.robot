*** Settings ***
Library                         QMobile                     mobile_browser=True         configs=${CURDIR}${/}..${/}configs${/}local_browser.yaml
Library                         DebugLibrary
Library                         DateTime
Resource                        common.robot

*** Variables ***
# Environment variables
${base_url}                     https://pernod-ricard-cgcloud--${env}.sandbox.lightning.force.com/lightning

# LOGIN
${username_field}               //input[@id\='username']
${password_field}               //input[@id\='password']
${submit_button}                //input[@id\='Login']

# VISIT_SCHEDULE
${BP_visit_goal_visit}          //span[text()\='${BP_visit_goal}']
${add_to_selection_button}      //button[@title\='Déplacez la sélection vers Sélectionné']
${visit_calendar_tile}          //div[@class\='fc-content']
${close_visit_calendar_tile}    //div[@class\='fc-content-close']
${visit_to_plan}                //th[@data-label\='Name']
${column_visit_name}            //th[@data-label\='Name']/div
${column_visit_street}          //td[@data-label\='Street']
${column_visit_address}         //td[@data-label\='Address']
${column_visit_name_first_BP_visit_goal_visit}              //td[@data-label\='Visit Goal']/div[text()\='${BP_visit_goal}']/ancestor::tr/th[3]/div
${column_visit_address_first_BP_visit_goal_visit}           (//td[@data-label\='Visit Goal']/div[text()\='${BP_visit_goal}']/ancestor::tr/td[1])
${line_first_BP_visit_goal_visit}                           //td[@data-label\='Visit Goal']/div[text()\='${BP_visit_goal}']/ancestor::tr/th[@data-label\='Name']
${current_time_indicator}       //*[@class\='fc-now-indicator fc-now-indicator-line']
${week_filter_dropdown_list}    //lightning-base-combobox-item
${filter_button}                //button[text()\='Filtre']
${filter_button_visite_HBP}     //span[@title\='Visites Hors BP']
${filter_option_circuit}        //button[text()\='Circuit']
${close_filter_button}          //button[@title\='Close']
${apply_filter_button}          //button[text()\='Recherche']

# TABLE
${bottom_of_table}              (//div[@tabindex\='0'])[2]

# VISIT_OVERVIEW
${checkbox_prepared_checked}    //span[@title='Préparée']/following-sibling::div/*//img[@class=' checked']
${checkbox_prepared_unchecked}                              //*[contains(text(),'Préparée')]/following-sibling::div//*[@class\=' unchecked']
${checkbox_action_dn}           //*[contains(text(),'Action DN')]/preceding-sibling::div//input[@type\='checkbox']
${comment_field_action_dn}      //*[contains(text(),'Action DN')]/following-sibling::div//input
${checkbox_action_pvc_constate}                             //*[contains(text(),'Action PVC constaté')]/preceding-sibling::div//input[@type\='checkbox']
${comment_field_action_pvc_constate}                        //*[contains(text(),'Action PVC constaté')]/following-sibling::div//input
${checkbox_nego_visibilite}     //*[contains(text(),'Négo visibilité')]/preceding-sibling::div//input[@type\='checkbox']
${action_buttons}               //div[@class='slds-global-header__item']/ul
${visit_title_header}           //div[text()='Visite']/following-sibling::div//a
${button_modify_visit}          //a[@title\='Modifier']
${field_modify_start_date_visit}                            (//*[text()\='Heure de début planifiée']/ancestor::fieldset//input)[1]
${cell_calendar_last_saturday_of_the_month}                 (//td[@role\='gridcell']/span[contains(@class,'weekend')])[11]
${field_modify_end_date_visit}                              (//*[text()\='Heure de fin planifiée']/ancestor::fieldset//input)[1]
${button_save_modification_visit}                           //button[@title\='Enregistrer']
${visit_type_header}            //span[@title\='Type de visite']/following-sibling::div//span

# PROMOTION_AGREEMENT_LIST
${agreements_of_the_list}       //a[contains(@title, 'PA-')]
${OP_trade_attached}            //dt[text()='Promotion:']/following-sibling::dd//a
${OP_trade_attached_BRI}        //dt[text()='Nb de BRI:']/following-sibling::dd//*
${button_quotas_promotion_menu}                             //span[@class\='title'][text()\='Quotas']

# ORDER_LIST
${orders_of_the_list}           //a[string-length(@title) = '8' and contains(@title, '0')]
${field_code_territoire}        //*[@field-label\='Code territoire']//*[@slot\='outputField']

*** Keywords ***
Start Suite
    Set Library Search Order    QForce                      QMobile
    SetConfig                   DefaultTimeout              15
    OpenBrowser                 about:blank                 Safari
    ${config_value}=            SetConfig                   InputHandler                javascript
    Set Suite Variable          ${config_value}
    Log Variables


Start Suite Mobile
    LoadConfig                  ${CURDIR}${/}..${/}configs${/}local_browser.yaml
    Set Library Search Order    QMobile                     QForce
    SetConfig                   DefaultTimeout              15
    OpenBrowser                 about:blank                 Safari
    ${config_value}=            SetConfig                   InputHandler                javascript
    Set Suite Variable          ${config_value}
    Log Variables


End Suite
    CloseAllBrowsers


End Suite Mobile
    CloseAllBrowsers
    CloseAllApplications


Home
    GoTo                        ${base_url}
    Sleep                       2
    ${login_method}=            IsText                      Log In with a Different Account                         2
    Run Keyword If              ${login_method}             ClickText                   Log In with a Different Account
    ${login_status}=            IsText                      Remember me                 2
    Run Keyword If              ${login_status}             Log In
    Wait Until Keyword Succeeds                             30s                         5sec                        VerifyText                  Accueil


Log In
    TypeText                    ${username_field}           ${username}
    TypeSecret                  ${password_field}           ${password}
    ClickElement                ${submit_button}


Log Out
    ClickText                   Se déconnecter
    Sleep                       2
    VerifyText                  Forgot Your Password?


Check If E2E Execution
    [Arguments]                 ${E2E_variable}
    ${is_run_E2E}=              Run Keyword And Return Status                           Should not Be Empty         ${E2E_variable}
    [Return]                    ${is_run_E2E}


Check If HBP Visit Has Been Planned And Click Visit
    [Arguments]                 ${visit_text}
    Check If E2E Execution      ${visit_text}
    ${has_visit_been_planned}                               Run Keyword And Return Status                           Should not Be Empty         ${visit_text}
    Run Keyword If              ${has_visit_been_planned}                               Click Planned Visit         ${visit_text}
    ...                         ELSE                        Click Random HBP Planned Visit


Check If BP Visit Has Been Planned And Click Visit
    [Arguments]                 ${visit_text}
    ${visit_text_length}=       GetLength                   ${visit_text}
    ${has_visit_been_planned}=                              Run Keyword And Return Status                           Should Be True              ${visit_text_length}>3
    Run Keyword If              ${has_visit_been_planned}                               Click Planned Visit         ${visit_text}
    ...                         ELSE                        Click Random Planned Visit


Click Planned Visit
    [Arguments]                 ${visit_text}
    ClickText                   ${visit_text}


Click Random Planned Visit
    ${is_BP_visit_scheduled}=                               isElement                   ${BP_visit_goal_visit}      timeout=15
    IF                          ${is_BP_visit_scheduled}
        ScrollTo                ${BP_visit_goal_visit}
        ClickElement            ${BP_visit_goal_visit}
    ELSE
        LogScreenshot
        PassExecution           No BP visit with main Objective "${BP_visit_goal}" available in the Calendar. Try running your command with "-v BP_visit_goal:[insert_visit_goal]"
    END


Click Random HBP Planned Visit
    ClickText                   Hors Business Planning


Check Checkbox If Visible
    [Arguments]                 ${title}
    ${is_visible}=              Run Keyword And Return Status                           VerifyText                  ${title}                    timeout=2s
    IF                          ${is_visible}
        ClickElement            //*[@title\='${title}']//ancestor::*[@role\='listitem']//table//tbody/tr[1]//input[@type\='checkbox']
        ${ref_produit_checked}=                             GetText                     (//span[text()\='${title}']/ancestor::div[1]/following-sibling::div//a[@title\='CGC_ProductName__c'])[1]
        Set Global Variable     ${ref_produit_checked_${title}}                         ${ref_produit_checked}
    END
    RETURN                      ${is_visible}


Navigate To Page
    [Arguments]                 ${page}
    ${endpoint}=                Set Variable If
    ...                         '${page}' == 'HOME'         /page/home
    ...                         '${page}' == 'VISIT_SCHEDULE'                           /n/CGC_PRF_Visit_Schedule_Single_Page
    ...                         '${page}' == 'STORE'        /o/RetailStore/list
    ...                         '${page}' == 'PROMOTION'    /o/Promotion/list
    ...                         '${page}' == 'PROMOTION_AGREEMENT_LIST'                 /o/CGC_PromotionAgreement__c/list
    ...                         '${page}' == 'ORDER_LIST'                               /o/Order/list

    ${url}=                     Set Variable                ${base_url}${endpoint}
    Go To                       ${url}


VerifyPage
    [Arguments]                 ${page}
    Scroll                      //html                      page_up

    IF                          '${page}'=='LOGIN'
        Run Keyword And Continue On Failure                 VerifyText                  Username
        Run Keyword And Continue On Failure                 VerifyText                  Password
        Run Keyword And Continue On Failure                 VerifyText                  Log In to Sandbox
        Run Keyword And Continue On Failure                 VerifyCheckboxValue         Remember me                 off
        Run Keyword And Continue On Failure                 VerifyText                  Forgot Your Password?
        Run Keyword If          '${env}'=='staging'         Run Keyword And Continue On Failure                     VerifyText                  Log in with Pernod Ricard SSO

    ELSE IF                     '${page}'=='PASSWORD_RECOVERY'
        Run Keyword And Continue On Failure                 VerifyText                  Having trouble logging in?
        Run Keyword And Continue On Failure                 VerifyText                  Username
        Run Keyword And Continue On Failure                 VerifyText                  Continue

    ELSE IF                     '${page}'=='PROMOTION_AGREEMENT_LIST'
        Run Keyword And Continue On Failure                 VerifyText                  Récemment visualisés
        Run Keyword And Continue On Failure                 VerifyText                  Recherchez dans cette liste..
        Run Keyword And Continue On Failure                 Verify Column Name          Num auto
        Run Keyword And Continue On Failure                 Verify Column Name          Client
        Run Keyword And Continue On Failure                 Verify Column Name          Type
        Run Keyword And Continue On Failure                 Verify Column Name          Date de début
        Run Keyword And Continue On Failure                 Verify Column Name          Date de fin
        Run Keyword And Continue On Failure                 Verify Column Name          Statut
        Run Keyword And Continue On Failure                 Verify Column Name          Promotion enseigne
        Run Keyword And Continue On Failure                 Verify Column Name          Promotion trade
        Run Keyword And Continue On Failure                 Compare Actual Number Of Line To Number Of Line Announced In Table                  Récemment visualisés

    ELSE IF                     '${page}'=='PROMOTION_AGREEMENT'
        Run Keyword And Continue On Failure                 VerifyText                  Statut
        Run Keyword And Continue On Failure                 VerifyText                  Type
        Run Keyword And Continue On Failure                 VerifyText                  Date de début
        Run Keyword And Continue On Failure                 VerifyText                  Date de fin
        Run Keyword And Continue On Failure                 VerifyText                  Promotion enseigne
        Run Keyword And Continue On Failure                 VerifyText                  Num auto
        Run Keyword And Continue On Failure                 VerifyText                  Client
        Run Keyword And Continue On Failure                 VerifyText                  Créé par
        Run Keyword And Continue On Failure                 VerifyText                  Dernière modification par
        Run Keyword And Continue On Failure                 VerifyText                  Moyens Accord \(
        Run Keyword And Continue On Failure                 VerifyText                  Produits Accord MEA \(

    ELSE IF                     '${page}'=='PROMOTION'
        Run Keyword And Continue On Failure                 Verify A Date Is Displayed Below                        Date de début
        Run Keyword And Continue On Failure                 Verify A Date Is Displayed Below                        Date de fin
        Run Keyword And Continue On Failure                 Verify Text Below           Marque                      PASTIS_51
        Run Keyword And Continue On Failure                 Verify Text Below           Statut                      Confirmé
        Run Keyword And Continue On Failure                 Verify Text Below           Type                        MEA
        Run Keyword And Continue On Failure                 VerifyText                  Promotion multimarque

    ELSE IF                     '${page}'=='PROMOTION_DETAILS'
        Run Keyword And Continue On Failure                 VerifyText                  Nom
        Run Keyword And Continue On Failure                 VerifyText                  Activité
        Run Keyword And Continue On Failure                 VerifyText                  Enseigne
        Run Keyword And Continue On Failure                 VerifyText                  Soumis à quota
        Run Keyword And Continue On Failure                 VerifyText                  Description
        Run Keyword And Continue On Failure                 VerifyText                  Centrale
        Run Keyword And Continue On Failure                 VerifyText                  Quota bloquant
        Run Keyword And Continue On Failure                 VerifyText                  Pas de ciblage
        Run Keyword And Continue On Failure                 VerifyText                  Marché/Pays

    ELSE IF                     '${page}'=='PROMOTION_QUOTAS'
        Run Keyword And Continue On Failure                 VerifyText                  Nom de quota
        Run Keyword And Continue On Failure                 VerifyText                  Code Territoire
        Run Keyword And Continue On Failure                 VerifyText                  Quota
        Run Keyword And Continue On Failure                 VerifyText                  Engagé
        Run Keyword And Continue On Failure                 VerifyText                  RAF

    ELSE IF                     '${page}'=='VISIT_SCHEDULE'
        Run Keyword And Continue On Failure                 VerifyText                  Reco BP
        Run Keyword And Continue On Failure                 VerifyText                  Visites Hors BP
        Run Keyword And Continue On Failure                 VerifyText                  Nouvel événement
        Run Keyword And Continue On Failure                 VerifyText                  Sem
        Run Keyword And Continue On Failure                 VerifyText                  Filtre
        Run Keyword And Continue On Failure                 VerifyText                  Aujourd’hui
        Run Keyword And Continue On Failure                 VerifyText                  Avec weekend
        Run Keyword And Continue On Failure                 VerifyText                  Sans weekend

    ELSE IF                     '${page}'=='ORDER_LIST'
        Run Keyword And Continue On Failure                 VerifyText                  Récemment visualisés
        Run Keyword And Continue On Failure                 VerifyText                  Recherchez dans cette liste..
        Run Keyword And Continue On Failure                 Verify Column Name          Numéro de commande
        Run Keyword And Continue On Failure                 Verify Column Name          Client
        Run Keyword And Continue On Failure                 Verify Column Name          Type de commande
        Run Keyword And Continue On Failure                 Verify Column Name          Date de commande
        Run Keyword And Continue On Failure                 Verify Column Name          Date de livraison négociée
        Run Keyword And Continue On Failure                 Verify Column Name          Date de livraison
        Run Keyword And Continue On Failure                 Verify Column Name          Statut
        Run Keyword And Continue On Failure                 Verify Column Name          Dernière modification
        Run Keyword And Continue On Failure                 Compare Actual Number Of Line To Number Of Line Announced In Table                  Récemment visualisés

    ELSE IF                     '${page}'=='ORDER'
        Run Keyword And Continue On Failure                 VerifyText                  Client
        Run Keyword And Continue On Failure                 VerifyText                  Type de commande
        Run Keyword And Continue On Failure                 VerifyText                  Date de commande
        Run Keyword And Continue On Failure                 VerifyText                  Date de livraison négociée
        Run Keyword And Continue On Failure                 VerifyText                  Date de livraison
        Run Keyword And Continue On Failure                 VerifyText                  Statut
        Run Keyword And Continue On Failure                 VerifyText                  Client
        Run Keyword And Continue On Failure                 VerifyText                  Propriétaire de la commande
        Run Keyword And Continue On Failure                 VerifyText                  Dernière modification par
        Run Keyword And Continue On Failure                 VerifyText                  Créé par
        Run Keyword And Continue On Failure                 VerifyText                  Code territoire

    END


Add Option To Filter
    [Arguments]                 ${filter_option}
    ClickText                   ${filter_option}
    ClickElement                ${add_to_selection_button}


Scroll And Drag Drop
    [Arguments]                 ${scroll_element}           ${drag_element}             ${below_value}              ${drag_time}
    ScrollTo                    ${drag_element}/ancestor::tr/preceding-sibling::tr[2]
    Scroll And Drag Drop HBP    ${scroll_element}           ${drag_element}             ${below_value}              ${drag_time}


Scroll And Drag Drop HBP
    [Arguments]                 ${scroll_element}           ${drag_element}             ${below_value}              ${drag_time}
    ScrollTo                    ${scroll_element}
    DragDrop                    ${drag_element}             ${scroll_element}           below=${below_value}        dragtime=${drag_time}


Verify Text Below
    [Arguments]                 ${title}                    ${expected}
    ${actual_text}=             Get Text Below              ${title}
    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${actual_text}              ${expected}


Verify A Date Is Displayed Below
    [Arguments]                 ${title}
    ${starting_date_text}=      Get Text Below              ${title}
    Run Keyword And Continue On Failure                     Verify String Is A Date     ${starting_date_text}


Get Text Below
    [Arguments]                 ${title}
    ${text}=                    GetAttribute                (//*[@title\='${title}']/following-sibling::div//span)[1]                           innerText
    [Return]                    ${text}


Get Text Below Agreement
    [Arguments]                 ${title}
    ${text}=                    GetAttribute                (//td[@data-label\='${title}']/div)[1]                  innerText
    [Return]                    ${text}


Compare Actual Number Of Line To Number Of Line Announced In Table 
    [Arguments]                 ${title}
    ScrollTo                    xpath\=${bottom_of_table}
    ${number_of_element_on_page}=                           GetElementCount             //table[@aria-label\='${title}']//tr
    ${number_of_lines_in_table}=                            Evaluate                    ${number_of_element_on_page}-1                          #When the table is empty there is 1 element on the page.
    ${text_number_of_lines_announced}=                      GetText                     //span[@aria-label\='${title}']
    ${number_of_lines_announced}=                           Extract Numbers From String                             ${text_number_of_lines_announced}
    Should Be Equal             ${number_of_lines_in_table}                             ${number_of_lines_announced}


Verify Column Name 
    [Arguments]                 ${name}
    VerifyElement               //th[@title\='${name}']


Unprepare Visit From Calendar 
    ${number_of_visit_planned}=                             Get Element Count           ${visit_calendar_tile}
    ${number_of_visit_planned}=                             Convert To String           ${number_of_visit_planned}

    WHILE                       ${number_of_visit_planned} > 0
        ClickElement            (${visit_calendar_tile})\[${number_of_visit_planned}\]
        ${visit_status}=        Get Text Below              Statut
        ${is_visit_prepared}=                               IsElement                   ${checkbox_prepared_checked}                            timeout=5

        IF                      '${visit_status}'=='Terminé'
            ClickElement        ${button_modify_visit}
            ClickElement        ${field_modify_start_date_visit}
            ClickElement        ${cell_calendar_last_saturday_of_the_month}
            ClickElement        ${field_modify_end_date_visit}
            ClickElement        ${cell_calendar_last_saturday_of_the_month}
            ClickElement        ${button_save_modification_visit}

        ELSE IF                 ${is_visit_prepared}
            Prepare BP Visit Priority Action
            Check Visit Other Tasks Checkbox
        END

        ${number_of_visit_planned}=                         Evaluate                    ${number_of_visit_planned}-1
        Navigate To Page        VISIT_SCHEDULE
    END


Remove Visit From Calendar
    ${number_of_visit_planned}=                             Get Element Count           ${visit_calendar_tile}

    WHILE                       ${number_of_visit_planned} > 0
        ScrollTo                (${close_visit_calendar_tile})\[${number_of_visit_planned}\]
        ClickElement            (${close_visit_calendar_tile})\[${number_of_visit_planned}\]
        Close Alert             Accept
        ${number_of_visit_planned}=                         Get Element Count           ${visit_calendar_tile}      timeout=2
        Sleep                   1
    END


Prepare BP Visit Priority Action
    ${visite_type}=             GetText                     ${visit_type_header}

    IF                          '${visite_type}' != 'Hors Business Planning'
        Sleep                   3
        ${is_innovations_manquantes_checked}=               Check Checkbox If Visible                               INNOVATIONS MANQUANTES
        Set Global Variable     ${is_innovations_manquantes_checked}

        ${is_references_obligatoires_manquantes_checked}=                               Check Checkbox If Visible                               RÉFÉRENCES OBLIGATOIRES MANQUANTES
        Set Global Variable     ${is_references_obligatoires_manquantes_checked}

        ${is_references_additionnelles_manquantes_checked}=                             Check Checkbox If Visible                               RÉFÉRENCES ADDITIONNELLES MANQUANTES
        Set Global Variable     ${is_references_additionnelles_manquantes_checked}

        ${is_rupture_sur_les_6_derniers_mois_checked}=      Check Checkbox If Visible                               RUPTURE SUR LES 6 DERNIERS MOIS
        Set Global Variable     ${is_rupture_sur_les_6_derniers_mois_checked}

        ${is_promo_en_cours_checked}=                       Check Checkbox If Visible                               PROMOTIONS EN COURS
        Set Global Variable     ${is_promo_en_cours_checked}
    END


Prepare Visit Other Tasks
    ${random_string_action_dn}=                             Generate Random String With Date                        100
    Set Global Variable         ${random_string_action_dn}
    TypeText                    ${comment_field_action_dn}                              input_text=${random_string_action_dn}

    ${random_string_action_pvc_constate}=                   Generate Random String With Date                        100
    Set Global Variable         ${random_string_action_pvc_constate}
    TypeText                    ${comment_field_action_pvc_constate}                    input_text=${random_string_action_pvc_constate}

    ClickElement                ${checkbox_nego_visibilite}
    Save Preparation
    Set Global Variable         ${is_visit_prepared}        True


Check Visit Other Tasks Checkbox    
    ClickElement                ${checkbox_action_dn}
    ClickElement                ${checkbox_action_pvc_constate}
    ClickElement                ${checkbox_nego_visibilite}
    Save Preparation


Save Preparation
    HoverText                   Enregistrer
    ClickText                   Enregistrer