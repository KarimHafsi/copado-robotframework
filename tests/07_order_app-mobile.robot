*** Settings ***
Resource                        ../resources/app.robot
Suite Setup                     Start Suite Mobile
Suite Teardown                  End Suite Mobile

*** Test Cases ***
Check Orders Page UI Elements
    [Documentation]             Checking UI Elements for Activities Page
    [Tags]                      NEO-                        E2E_CMD                     UI
    Home
    ClickMenu                   COMMANDES
    VerifyPage                  ORDERS
    ClickText                   LISTE DES COMMANDES
    Run Keyword And Continue On Failure                     VerifyText                  CRÉER UNE COMMANDE


Create Furniture Order - Step 1/3
    [Documentation]             Complete Furniture Order first form
    [Tags]                      NEO-                        E2E_CMD
    Home
    ClickMenu                   COMMANDES
    Run Keyword And Continue On Failure                     VerifyPage                  ORDERS
    ClickText                   LISTE DES COMMANDES
    ClickText                   CRÉER UNE COMMANDE
    Run Keyword And Continue On Failure                     VerifyText                  Nouvelle commande
    ClickElement                ${field_order_type}
    ClickText                   Commande de meuble
    ClickElement                ${field_client}
    ClickText                   Rechercher un client
    WriteText                   ${furniture_order_retail_store}                         clear=false
    HideKeyboard
    ClickElement                ${furniture_order_retail_store_option}
    ClickElement                ${button_next}


Create Furniture Order - Step 2/3
    [Documentation]             Complete Furniture Order second form
    [Tags]                      NEO-                        E2E_CMD
    ClickElement                ${field_delivery_details}
    WriteText                   ${delivery_details}         clear=false
    HideKeyboard

    ClickElement                ${field_delivery_date}
    ClickIcon                   back_arrow
    ${value_delivery_date}=     GetValue                    xpath\=${field_delivery_date}/XCUIElementTypeStaticText[1]             value

    ClickElement                ${field_delivery_hour}

    Swipe                       550                         400                         550                         300
    ClickElement                ${validate_button}
    ${value_delivery_hour}=     GetValue                    xpath\=${field_delivery_hour}/XCUIElementTypeStaticText[1]             value


    ${value_delivery_address}=                              GetValue                    xpath\=${field_delivery_address}           value

    ClickElement                ${field_delivery_contact}
    ClickElement                ${first_delivery_contact_option}
    ${value_delivery_contact}=                              GetValue                    xpath\=${field_delivery_contact}/XCUIElementTypeStaticText[1]    value
    Swipe                       550                         400                         550                         300

    ClickElement                ${radio_button_oui}
    Swipe                       550                         400                         550                         200

    ClickElement                ${field_comment}
    ${random_string_furniture_order_comment}=               Generate Random String With Date                        100
    WriteText                   ${random_string_furniture_order_comment}                clear=false
    HideKeyboard
    ${value_delivery_phone}=    GetValue                    xpath\=${field_delivery_phone}                          value

    ClickElement                ${field_furniture_reference}
    ${is_element_with_quota_displayed}=                     Run Keyword And Return Status                           VerifyElement           ${first_reference_with_quota}

    IF                          ${is_element_with_quota_displayed}
        ${string_quota_first_element_displayed}=            GetValue                    xpath\=${first_reference_with_quota}       value
        ${value_quota_first_element_displayed}=             Remove Undesired String     ${string_quota_first_element_displayed}    Quota(s) disponible(s) :
        ${is_element_with_quota_displayed}=                 Run Keyword And Return Status                           Should Be True          ${value_quota_first_element_displayed}>0
    END

    IF                          ${is_element_with_quota_displayed}
        ClickElement            ${first_reference_with_quota}
        ClickElement            ${button_next}

        # Second form of the furniture order
        Run Keyword And Continue On Failure                 VerifyText                  ${delivery_details}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_hour}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_date}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_address}

        Swipe                   550                         400                         550                         100
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_contact}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_phone}
        Run Keyword And Continue On Failure                 VerifyText                  ${random_string_furniture_order_comment}
        ClickText               ENREGISTRER LA COMMANDE

        Run Keyword And Continue On Failure                 VerifyText                  Votre commande de meuble a été enregistrée avec succès
        Run Keyword And Continue On Failure                 VerifyText                  VOIR MA LISTE DE COMMANDES
        Run Keyword And Continue On Failure                 VerifyText                  FAIRE UNE NOUVELLE COMMANDES
        ClickText               VOIR MA LISTE DE COMMANDES

        # Open last draft furniture order from retail store
        ${number_of_draft_order}=                           Get Matching Xpath Count    ${furniture_order_retail_store_option}/following-sibling::XCUIElementTypeStaticText[@value\="Statut: Brouillon"]
        ClickElement            ${furniture_order_retail_store_option}/following-sibling::XCUIElementTypeStaticText[@value\="Statut: Brouillon"][${number_of_draft_order}]
        Run Keyword And Continue On Failure                 VerifyText                  ${delivery_details}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_hour}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_date}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_address}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_contact}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_phone}
        Run Keyword And Continue On Failure                 VerifyText                  ${random_string_furniture_order_comment}


    ELSE
        Log                     No furniture with quota available. Can't create funriture order.                    console=true
    END
    ClickCoordinate             1000                        600                         #Get out of popup window

    Synch App Data
    ${is_success_displayed}=    Run Keyword And Return Status                           VerifyText                  Succès         timeout=300    #5min

    WHILE                       ${is_success_displayed}
        ClickElement            ${confirmation_button_synch}
        ${is_success_displayed}=                            Run Keyword And Return Status                           VerifyText     Succès
    END

    VerifyNoText                Succès

    Set Global Variable         ${value_delivery_hour}
    Set Global Variable         ${value_delivery_date}
    Set Global Variable         ${value_delivery_address}
    Set Global Variable         ${value_delivery_contact}
    Set Global Variable         ${value_delivery_phone}
    Set Global Variable         ${random_string_furniture_order_comment}


*** Comments ***
Debug mode
    [Documentation]             Open Debug mode
    [Tags]                      @Debug
    OpenApp
    Debug