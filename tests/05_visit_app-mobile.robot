*** Settings ***
Resource                        ../resources/app.robot
Suite Setup                     Start Suite Mobile
Suite Teardown                  End Suite Mobile

*** Test Cases ***
Check Activities Page UI Elements
    [Documentation]             Checking UI Elements for Activities Page
    [Tags]                      NEO-10222                   UI
    Home
    ClickMenu                   ACTIVITÉS
    VerifyPage                  ACTIVITY_DAY

    ClickText                   MA SEMAINE
    VerifyPage                  ACTIVITY_WEEK
    VerifyCalendar              False                       #False means "without weekend displayed"

    ClickText                   Sans week-end
    ClickText                   Avec week-end
    VerifyCalendar              True                        #True means "with weekend displayed"


End-to-end of a Visit - Step 0/7
    [Documentation]             Navigate to Activity Page
    [Tags]                      E2E_VISIT-HBP               E2E_VISIT-BP
    Home
    Set Global Variable         ${is_step_0_success}        False

    Run Keyword If              ${is_BP_visit_planned}      Run Keyword And Ignore Error                            Element Should Be Visible                               ${BP_visit_type_text}
    Run Keyword If              ${is_HBP_visit_planned}     Run Keyword And Ignore Error                            Element Should Be Visible                               ${HBP_visit_type_text}

    ClickMenu                   ACTIVITÉS
    ClickText                   MA JOURNÉE
    ${many_visites}             IsText                      Voir toutes les visites     timeout=3

    IF                          ${many_visites}
        ClickText               Voir toutes les visites
    END

    Check If Visit Has Been Planned And Click Visit         ${BP_visit_name}

    VerifyPage                  VISIT
    ${visit_not_started}=       IsText                      LANCER LA VISITE            #Check if visit is started
    Run Keyword If              ${visit_not_started}        ClickText                   LANCER LA VISITE            #If visit not started, click LANCER LA VISITE
    ...                         ELSE                        ClickIcon                   proceed_visit               #Else Click the proceed with visit button

    Set Global Variable         ${is_step_0_success}        True


End-to-end of a Visit - Step 1/7
    [Documentation]             Checking Objectives
    [Tags]                      NEO-10223                   E2E_VISIT-HBP               E2E_VISIT-BP
    E2E Check Previous Step Status                          ${is_step_0_success}
    Set Global Variable         ${is_step_1_success}        False
    Navigate To Visit Step      1
    VerifyPage                  VISIT_STEP_1

    ClickText                   Consulter le compte-rendu du
    ${is_last_visit_report_comment_displayed}=              Run Keyword And Return Status                           VerifyElement               ${last_visit_report_field}
    Set Global Variable         ${is_last_visit_report_comment_displayed}
    IF                          ${is_last_visit_report_comment_displayed}

        ${last_visit_report_value_step_1}=                  GetValue                    xpath\=${last_visit_report_field}                       value
        Set Global Variable     ${last_visit_report_value_step_1}
    END


    ClickIcon                   close                       match_threshold=0.5
    ClickCoordinate             100                         100
    ClickCoordinate             100                         100                         #Ensure the selection of the main frame
    Check Visit Objectives
    Check Other Tasks Comments
    ClickElement                ${button_next}

    Set Global Variable         ${is_step_1_success}        True


End-to-end of a Visit - Step 2/7
    [Documentation]             4P Statement
    [Tags]                      E2E_VISIT-HBP               E2E_VISIT-BP                NEO-10224
    E2E Check Previous Step Status                          ${is_step_1_success}
    Set Global Variable         ${is_step_2_success}        False
    Navigate To Visit Step      2

    ${rupture_popup}            IsText                      Suite à 2 ruptures          timeout=10

    IF                          ${rupture_popup}
        ClickText               OK
    END

    VerifyPage                  VISIT_STEP_2

    #Search for "Ricard" in search bar
    WriteText                   Ricard
    HideKeyboard
    VerifyElement               ${field_name_product_first_line_contains_ricard}
    ClearText                   ${search_bar_contains_ricard}
    HideKeyboard

    #Add reference to Relevé 4P
    ClickText                   AJOUTER UNE REFERENCE
    WriteText                   FLASK
    #PressKeycode               KEYCODE_ENTER
    ClickIcon                   close
    Run Keyword And Ignore Error                            ClickIcon                   close

    #Check "Pres." checkbox
    ClickElement                ${pres_checkbox_first_line}
    ClickElement                ${pres_checkbox_first_line}
    Check If Field is Empty And Fill It                     ${field_pvc_first_line}     ${value_pvc}
    Check If Field is Empty And Fill It                     ${field_facing_first_line}                              ${value_facing}

    ${value_facing_displayed_init}=                         GetValue                    xpath\=${field_facing_first_line}                       value

    #Click the minus icon for facing
    ClickIcon                   minus_button
    ${value_facing_displayed_minus}=                        GetValue                    xpath\=${field_facing_first_line}                       value
    ${value_facing_should_display}=                         Evaluate                    ${value_facing_displayed_init}-1
    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${value_facing_displayed_minus}                         ${value_facing_should_display}

    #Click the plus icon for facing
    ClickIcon                   plus_button
    ${value_facing_displayed_plus}=                         GetValue                    xpath\=${field_facing_first_line}                       value
    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${value_facing_displayed_plus}                          ${value_facing_displayed_init}

    #Check "Out of Stock" checkbox
    ClickCoordinate             1012                        378
    ${date_today_raw}=          Get Current Date            UTC                         exclude_millis=yes
    ${date_today}=              Convert Date Format         ${date_today_raw}
    Run Keyword And Continue On Failure                     VerifyElement               xpath\=//XCUIElementTypeStaticText[@value\="${date_today}"]
    ClickCoordinate             1012                        378

    #Check Box checkbox
    Swipe                       start_x=1000                start_y=500                 offset_x=-500               offset_y=0
    ClickElement                ${box_checkbox_first_line}
    ClickElement                ${box_checkbox_first_line}
    Swipe                       start_x=100                 start_y=500                 offset_x=500                offset_y=500

    #Reorganize products
    ClickText                   RÉORGANISER REF
    ClickIcon                   checkbox
    ClickIcon                   right_arrow
    WriteText                   RICARD                      clear=false
    VerifyText                  RICARD
    ClickIcon                   close                       match_threshold=0.5

    #Filter On Business Priority
    ClickText                   PRIORITÉ BUSINESS
    ${priorite_business_filter_important_checkbox_status}=                              GetText                     ${priorite_business_filter_important_checkbox}

    IF                          ${priorite_business_filter_important_checkbox_status}==0
        ClickElement            ${priorite_business_filter_important_checkbox}
    END

    ${priorite_business_filter_secondaire_checkbox_status}=                             GetText                     ${priorite_business_filter_secondaire_checkbox}

    IF                          ${priorite_business_filter_secondaire_checkbox_status}==0
        ClickElement            ${priorite_business_filter_secondaire_checkbox}
    END

    ClickText                   PRIORITÉ BUSINESS           recognition_mode=vision

    #Search Products in List
    Check If Visit Has Been Planned And Search and Add Reference                        ${reference_produit_innovations_manquantes}             ${is_Innovation_visible}

    #Check if Products Selected During Visit Prep are There or Add Them
    #Select the first Product on the list and change the PVC field
    ${PVC_first_line}=          GetText                     ${field_pvc_first_line}
    ${is_PVC_first_line_empty}=                             Run Keyword And Return Status                           Should Be Empty             ${PVC_first_line}

    Run Keyword If              ${is_PVC_first_line_empty}                              Set Variable                ${PVC_first_line}           ${value_pvc}

    ${PVC_first_line_string}=                               Replace String              ${PVC_first_line}           ,                           .
    ${PVC_first_line_num}=      Convert To Number           ${PVC_first_line_string}
    ${PVC_first_line_new}=      Evaluate                    ${PVC_first_line_num}+1.37
    ${PVC_first_line_new}=      Convert To Number           ${PVC_first_line_new}       2
    ${PVC_first_line_new}=      Convert To String           ${PVC_first_line_new}
    ${PVC_first_line_new}=      Replace String              ${PVC_first_line_new}       .                           ,
    ClickElement                ${field_pvc_first_line}
    Sleep                       2
    Fill Field with Value       ${field_pvc_first_line}     ${PVC_first_line_new}

    ClickElement                ${bug_switch}
    Clear Search Bar
    ${number_of_element}        Get Matching Xpath Count    ${pvc_and_facing_fields_xpath}

    WHILE                       ${number_of_element} > 1
        Log To Console          (in loop begining) number of lines is: ${number_of_element}
        Click And Fill Elements With Incremented Index      ${pvc_and_facing_fields_xpath}                          ${number_of_element}
        Refresh List            ${bug_switch}
        Click And Fill Levels                               max_level_dropdown
        Click And Fill Levels                               min_level_dropdown
        Clear Search Bar
        Run Keyword and Continue On Failure                 Refresh Bug List
        ${number_of_element}    Get Matching Xpath Count    ${pvc_and_facing_fields_xpath}
        Log To Console          (in loop end) number of lines is: ${number_of_element}
    END

    ClickElement                ${button_next}

    Set Global Variable         ${is_step_2_success}        True


End-to-end of a Visit - Step 3/7
    [Documentation]             Fill in Survey
    [Tags]                      NEO-10225                   E2E_VISIT-HBP               E2E_VISIT-BP
    E2E Check Previous Step Status                          ${is_step_2_success}
    Set Global Variable         ${is_step_3_success}        False
    Navigate To Visit Step      3
    VerifyPage                  VISIT_STEP_3

    #Verify Relevé PDL GD
    ClickText                   Relevé PDL GD
    VerifyPage                  VISIT_STEP_3_RELEVÉ_PDL
    ClickText                   MES AUTRES ACTIONS

    #Verify Relevé de moyens GD
    ClickText                   Relevé de moyens GD
    VerifyPage                  VISIT_STEP_3_RELEVÉ__MOYEN_PDL
    ClickText                   Rechercher un moyen
    WriteText                   RIC                         clear=false
    Sleep                       2
    HideKeyboard
    ClickElement                xpath\=${field_qte_ajoutee_contains_ricard}
    WriteText                   0                           clear=false
    Sleep                       2
    HideKeyboard

    ${qte_ajoutee}=             Set Variable                0

    #Get Qté relevée and replace it by 0 if it's empty
    ${qte_relevee}=             GetValue                    xpath\=${field_qte_relevee_contains_ricard}             value
    ${is_qte_relevee_empty}=    Run Keyword And Return Status                           Should Be Equal As Strings                              ${qte_relevee}              \ue7d6
    ${qte_relevee}=             Set Variable If             ${is_qte_relevee_empty}     0

    #Get Qté totale and replace it by 0 if it's empty
    ${qte_totale}=              GetValue                    xpath\=${field_qte_totale_contains_ricard}              value
    ${is_qte_totale_empty}=     Run Keyword And Return Status                           Should Be Equal As Strings                              ${qte_totale}               \ue7d6
    ${qte_totale}=              Set Variable If             ${is_qte_relevee_empty}     0

    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${qte_relevee}              ${qte_totale}

    ClickIcon                   plus_button
    ${qte_ajoutee}=             GetValue                    xpath\=${field_qte_ajoutee_contains_ricard}             value
    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${qte_ajoutee}              1

    ClickIcon                   minus_button                match_threshold=0.7
    ${qte_ajoutee}=             GetValue                    xpath\=${field_qte_ajoutee_contains_ricard}             value
    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${qte_ajoutee}              0
    ${qte_releve_plus_ajoutee}=                             Evaluate                    ${qte_relevee}+${qte_ajoutee}
    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${qte_totale}               ${qte_releve_plus_ajoutee}

    ClickText                   VALIDER
    VerifyText                  Sauvegarde réussie
    ClickElement                ${confirmation_button}

    ClickElement                ${button_next}

    Set Global Variable         ${is_step_3_success}        True


End-to-end of a Visit - Step 4/7
    [Documentation]             Checking Business Operations & Creating MEA Pirate Agreement
    [Tags]                      E2E_VISIT-HBP               E2E_VISIT-BP                NEO-10226
    E2E Check Previous Step Status                          ${is_step_3_success}
    Set Global Variable         ${is_step_4_success}        False
    Navigate To Visit Step      4
    VerifyPage                  VISIT_STEP_4

    #Verify ending date of the Prospectus at the first line is in the future
    ${raw_value_ending_date_prospectus}=                    GetValue                    xpath\=${ending_date_prospectus}                        value
    ${value_ending_date_prospectus}=                        Remove String Using Regexp                              ${raw_value_ending_date_prospectus}                     (au )
    ${current_date}=            Get Today's Date            result_format=%Y-%m-%d
    ${datetime}=                Convert Date                ${current_date}             datetime
    ${value_ending_date_prospectus_year}=                   Remove String Using Regexp                              ${raw_value_ending_date_prospectus}                     (au \\d\\d/\\d\\d/)
    ${value_ending_date_prospectus_month_year}=             Remove String Using Regexp                              ${raw_value_ending_date_prospectus}                     (au \\d\\d/)
    ${value_ending_date_prospectus_month}=                  Remove String Using Regexp                              ${value_ending_date_prospectus_month_year}              (/${value_ending_date_prospectus_year})
    ${value_ending_date_prospectus_day}=                    Remove String Using Regexp                              ${value_ending_date_prospectus}                         (/\\d\\d/\\d\\d\\d\\d)

    IF                          not ${value_ending_date_prospectus_year}>${datetime.year}
        IF                      ${value_ending_date_prospectus_year}<${datetime.year}
            Log                 ${value_ending_date_prospectus} Ending date of the Prospectus opération is in the past.                         level=ERROR                 console=True
        ELSE IF                 ${value_ending_date_prospectus_year}==${datetime.year} and ${value_ending_date_prospectus_month}<${datetime.month}
            Log                 Log                         ${value_ending_date_prospectus} Ending date of the Prospectus opération is in the past.                         console=True
        ELSE IF                 ${value_ending_date_prospectus_year}<${datetime.year} and ${value_ending_date_prospectus_month}==${datetime.month} and ${value_ending_date_prospectus_day}<${datetime.day}
            Log                 Log                         ${value_ending_date_prospectus} Ending date of the Prospectus opération is in the past.                         console=True
        END
    END

    #Creating MEA Pirate Agreement
    ClickText                   ACCORDS
    ClickText                   CRÉER UN ACCORD
    VerifyText                  Que souhaitez-vous créer ?
    ClickText                   MEA PIRATE
    VerifyText                  Brief VA Salesbook
    ClickText                   Marque
    ClickText                   Chercher
    WriteText                   PASTIS                      clear=false
    HideKeyboard
    ClickText                   Marque
    ClickText                   PASTIS_51
    ClickText                   APPLIQUER LES FILTRES
    ClickIcon                   checkbox
    Sleep                       2
    ClickElement                ${BRI_input_field}
    WriteText                   ${value_BRI_PASTIS_51}      clear=false
    HideKeyboard
    ClickText                   Nb de BRI
    ClickElement                ${button_next}
    VerifyText                  Souhaitez-vous lier une promo enseigne
    ClickText                   Oui                         anchor=Souhaitez-vous lier une promo enseigne
    ${is_promo_enseigne_displayed}=                         IsIcon                      radiobutton

    IF                          ${is_promo_enseigne_displayed}
        ClickIcon               radiobutton
        Sleep                   2
        ClickElement            ${button_next}

        Click Field And Fill Value                          xpath\=(${first_line_PASTIS_51})[1]                     ${value_qte_negociee_PASTIS_51}
        HideKeyboard

        ClickText               VALIDER
        VerifyText              La MEA pirate a été créée avec succés !
        ClickText               OK

        ${cell_to_verify}=      Set Variable                1
        WHILE                   ${cell_to_verify}<=10       limit=12
            Verify Agreement Cell Value And Status And Fill Next Cell                   ${cell_to_verify}
            ${cell_to_verify}=                              Evaluate                    ${cell_to_verify}+1
        END
        ${is_promo_enseigne_created}=                       Set Variable                True
    ELSE
        Log                     No Promo Enseigne on ${env}, can't create new MEA pirate.                           console=True
        LogScreenshot
        ClickIcon               close
        ${is_promo_enseigne_created}=                       Set Variable                False
    END

    VerifyText                  BOOK PROMO SALESBOOK
    ClickText                   CRÉER UN ACCORD
    VerifyText                  Que souhaitez-vous créer ?
    ClickText                   VENTE ANIMÉE
    VerifyText                  Brief VA Salesbook
    ClickText                   Marque
    ClickText                   Chercher
    WriteText                   RIC                         clear=false
    HideKeyboard
    ClickText                   Marque
    ClickText                   RICARD
    ClickText                   APPLIQUER LES FILTRES

    ${is_vente_animee_available}=                           isIcon                      radiobutton

    IF                          ${is_vente_animee_available}
        ClickIcon               radiobutton
        ClickText               SUIVANT
        Sleep                   2

        #Choose duration
        ClearText               //XCUIElementTypeStaticText[@value\="NOMBRE DE JOURS"]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeTextField[1]
        HideKeyboard
        WriteText               1                           clear=false
        HideKeyboard

        #Choose Agence VA DSI test as Agence
        ClickElement            //XCUIElementTypeStaticText[@value\="AGENCE"]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
        ClickText               Chercher
        WriteText               DSI test                    clear=false
        ClickText               Agence VA DSI test
        ClickIcon               close

        #Choose tomorrow as starting date
        ClickElement            //XCUIElementTypeStaticText[@value\="DATE DE DÉBUT"]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
        ${today_day}=           Get Today's Date            %d
        ${today_day_number}=    Convert To Integer          ${today_day}
        ${tomorrow_day_number}=                             Evaluate                    ${today_day_number}+1

        IF                      ${tomorrow_day_number}>30
            ClickElement        //XCUIElementTypeStaticText[@value\="1"][2]
        ELSE
            ClickElement        xpath\=//XCUIElementTypeStaticText[@value\="${tomorrow_day_number}"]
        END

        ClickText               VALIDER

        #Choose tomorrow as ending date
        ClickElement            //XCUIElementTypeStaticText[@value\="DATE DE FIN"]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]

        IF                      ${tomorrow_day_number}>30
            ClickElement        //XCUIElementTypeStaticText[@value\="1"][2]
        ELSE
            ClickElement        xpath\=//XCUIElementTypeStaticText[@value\="${tomorrow_day_number}"]
        END

        ClickText               VALIDER
        ClickText               SUIVANT

        #Choose to not link an OP Trade
        ClickElement            //XCUIElementTypeStaticText[@value\="Non"]
        ClickText               SUIVANT

        #Get name of the first line in the table
        ${ricard_product_VA}=                               Get Element Attribute       ${first_line_product_ricard_VA}                         name

        #Fill Objectif de vente
        Click Field And Fill Value                          ${field_objectif_de_vente_VA}                           ${value_objectif_de_vente_VA}
        HideKeyboard

        #Fill Objectif de dégustation
        Click Field And Fill Value                          ${field_objectif_de_degustation_VA}                     ${value_objectif_de_degustation_VA}
        HideKeyboard

        ClickText               SUIVANT
        VerifyText              La vente animée a été créée avec succès !
        ClickElement            ${confirmation_button}

        #Verify creation Vente Animée
        ClickText               Négocié
        ClickText               Mettre à jour le
        ClickText               Communiqué agence
        Run Keyword And Continue On Failure                 Element Should Be Disabled                              ${field_objectif_de_vente_VA}
        Run Keyword And Continue On Failure                 Element Should Be Disabled                              ${field_objectif_de_degustation_VA}

        Swipe                   start_x=1000                start_y=500                 offset_x=-500               offset_y=0                  #Swipe the page down
        Sleep                   5
        ${is_table_scrolled_down}=                          isText                      RICARD 35CL

        WHILE                   not ${is_table_scrolled_down}
            Swipe               550                         400                         550                         300                         #Swipe the ARTICLES table down
            ${is_table_scrolled_down}=                      Run Keyword And Return Status                           VerifyElement               //XCUIElementTypeStaticText[@value\="${ricard_product_VA}"]
        END

        ${value_displayed_cell_to_verify}=                  GetValue                    xpath\=//XCUIElementTypeStaticText[@value\="${ricard_product_VA}"]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField    value
        Run Keyword And Continue On Failure                 Should Be Equal As Integers                             ${value_displayed_cell_to_verify}                       ${value_objectif_de_vente_VA}
        ${value_displayed_cell_to_verify}=                  GetValue                    xpath\=//XCUIElementTypeStaticText[@value\="${ricard_product_VA}"]/following-sibling::XCUIElementTypeOther[3]/XCUIElementTypeTextField    value
        Run Keyword And Continue On Failure                 Should Be Equal As Integers                             ${value_displayed_cell_to_verify}                       ${value_objectif_de_degustation_VA}

        ClickText               ENREGISTRER
        VerifyText              Communiqué agence
    ELSE
        Log                     No OP Trade on ${env}, can't create new Vente animée.                               console=True
        ClickIcon               close
    END

    ClickElement                ${button_next}

    Set Global Variable         ${is_step_4_success}        True


End-to-end of a Visit - Step 5/7
    [Documentation]             Validation of Objectives
    [Tags]                      NEO-10227                   E2E_VISIT-HBP               E2E_VISIT-BP
    E2E Check Previous Step Status                          ${is_step_4_success}
    Set Global Variable         ${is_step_5_success}        False
    Navigate To Visit Step      5
    VerifyPage                  VISIT_STEP_5

    ${visible}=                 IsIcon                      checkbox_2
    Run Keyword If              ${visible}                  ClickIcon                   checkbox_2
    ${visible}=                 IsIcon                      checkbox_2
    Run Keyword If              ${visible}                  ClickIcon                   checkbox_2

    Scroll Down To The Bottom Of The Page
    Check Visit Objectives
    Check Other Tasks Comments

    Click Element If Visible    ${action_dn_checkbox}
    Click Element If Visible    ${action_pvc_constate_checkbox}
    Click Element If Visible    ${controle_des_contacts_checkbox}

    ClickElement                ${button_next}
    ${visible}=                 IsText                      Êtes-vous sûr de vouloir passer à l'étape suivante ? Aucun objectif n'a été validé.

    IF                          ${visible}
        ClickIcon               close                       match_threshold=0.7
        Scroll Down To The Bottom Of The Page
        ${is_bottom_reached}=                               IsText                      AUTRES TÂCHES PRÉVUES

        WHILE                   not ${is_bottom_reached}
            Scroll Down To The Bottom Of The Page
            ${is_bottom_reached}=                           IsText                      AUTRES TÂCHES PRÉVUES
        END
        Check Visit Objectives
        Check Other Tasks Comments
        Click Element If Visible                            ${action_dn_checkbox}
        Click Element If Visible                            ${action_pvc_constate_checkbox}
        Click Element If Visible                            ${controle_des_contacts_checkbox}
        Click Element If Visible                            ${fourth_other_task_checkbox}

        ClickElement            ${button_next}
    END

    Set Global Variable         ${is_step_5_success}        True


End-to-end of a Visit - Step 6/7
    [Documentation]             Writing visit Report & Closing Visit
    [Tags]                      NEO-10228                   E2E_VISIT-HBP               E2E_VISIT-BP
    E2E Check Previous Step Status                          ${is_step_5_success}
    Set Global Variable         ${is_step_6_success}        False
    Navigate To Visit Step      6
    VerifyPage                  VISIT_STEP_6

    ClickText                   Consulter le compte-rendu du

    IF                          ${is_last_visit_report_comment_displayed}
        ${last_visit_report_value_step_6}=                  GetValue                    xpath\=${last_visit_report_field}                       value
        Run Keyword And Continue On Failure                 Should Be Equal As Strings                              ${last_visit_report_value_step_1}                       ${last_visit_report_value_step_6}
    END

    Sleep                       2
    ClickCoordinate             100                         100                         #ClickIcon close doesn't work for some reason.

    TypeText                    Saisir le compte-rendu      CRT testing
    HideKeyboard
    Sleep                       3

    ClickElement                ${finish_visit_button}
    Sleep                       3

    ${is_end_visit_confirmation_popup_displayed}=           isText                      Fin de la visite
    Run Keyword If              not ${is_end_visit_confirmation_popup_displayed}        ClickElement                ${finish_visit_button}
    ClickText                   OK                          anchor=Fin de la visite
    VerifyText                  Attention
    ClickText                   Synchroniser maintenant
    VerifyText                  ANNULER
    VerifyText                  Succès                      timeout=300
    Sleep                       2
    ClickElement                ${confirmation_button_synch}

    ${is_success_still_displayed}=                          Run Keyword And Return Status                           VerifyText                  Succès

    WHILE                       ${is_success_still_displayed}
        ClickElement            ${confirmation_button_synch}
        ${is_success_still_displayed}=                      Run Keyword And Return Status                           VerifyText                  Succès
    END

    Set Global Variable         ${is_step_6_success}        True


End-to-end of a Visit - Step 7/7
    [Documentation]             Update Agreement after Visit
    [Tags]                      NEO-10229                   E2E_VISIT-HBP               E2E_VISIT-BP
    E2E Check Previous Step Status                          ${is_step_6_success}

    ClickMenu                   ACTIVITÉS
    Check If Visit Has Been Planned And Click Visit         ${BP_visit_name}
    VerifyText                  CODE GÉOGRAPHIQUE :
    ClickText                   ACCORDS

    VerifyNoText                Nouvel accord

    ${agreement_MEA_ref_full_title}=                        GetValue                    xpath\=${agreement_MEA_title}                           value
    ${agreement_MEA_ref}=       Remove Undesired String     ${agreement_MEA_ref_full_title}                         Accord #
    Set Global Variable         ${agreement_MEA_ref}
    Log To Report And Console                               agreement_ref               ${agreement_MEA_ref}

    ClickText                   ${agreement_MEA_ref_full_title}
    VerifyText                  DATE DE FIN

    ${OP_trade_name_MEA_pastis_51}=                         GetValue                    xpath\=${cell_op_trade_name_MEA_pastis_51}              value
    Set Global Variable         ${OP_trade_name_MEA_pastis_51}
    Log To Report And Console                               op_trade_name_MEA_pastis_51                             ${OP_trade_name_MEA_pastis_51}

    ${value_OP_trade_quota}=    GetValue                    xpath\=${agreement_MEA_pastis_51_quota_cell}            value
    Set Global Variable         ${value_OP_trade_quota}
    Log To Report And Console                               OP_trade_quota_value        ${value_OP_trade_quota}

    Element Attribute Should Match                          xpath\=${field_quantite_negocie_first_line_PASTIS_51_accord}                        value                       ${value_qte_negociee_PASTIS_51}
    ClickIcon                   close

    ClickMenu                   ACTIVITÉS
    Sleep                       2