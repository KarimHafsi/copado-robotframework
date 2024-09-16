*** Settings ***
Library                         QMobile                     mobile_browser=False        configs=${CURDIR}${/}..${/}configs${/}local_app.yaml
Library                         DebugLibrary
Resource                        common.robot

*** Variables ***
# LOGIN
${login_username_field}         //XCUIElementTypeOther[@name\='Username']/following-sibling::XCUIElementTypeTextField
${login_password_field}         //XCUIElementTypeOther[@name\='Password']/following-sibling::XCUIElementTypeSecureTextField
${remember_me_checkbox}         //XCUIElementTypeSwitch
${confirmation_button_access}                               //XCUIElementTypeButton[@name\='Autoriser']

# HOME
${BP_visit_type_text}           //XCUIElementTypeStaticText[@value\='${BP_visit_type_displayed}']
${HBP_visit_type_text}          //XCUIElementTypeStaticText[@value\='${HBP_visit_type_displayed}']

# 4P_STATEMENT
${button_next}                  //XCUIElementTypeButton[@name\='SUIVANT']
${bug_switch}                   //XCUIElementTypeSwitch[@type\='XCUIElementTypeSwitch']
${field_pvc_first_line}         //XCUIElementTypeStaticText[@value\='PVC']/ancestor::XCUIElementTypeOther[2]/following-sibling::XCUIElementTypeTextField[1]
${field_facing_first_line}      //XCUIElementTypeStaticText[@value\='Facings']/ancestor::XCUIElementTypeOther[2]/following-sibling::XCUIElementTypeTextField[2]
${field_name_product_first_line_contains_ricard}            //XCUIElementTypeStaticText[@value\='Nom du produit / Code EAN / Code interne']/ancestor::XCUIElementTypeOther[2]/following-sibling::XCUIElementTypeOther[2]/XCUIElementTypeStaticText[contains(@value, 'RICARD')]
${search_bar_contains_ricard}                               //XCUIElementTypeOther[@name\='main']/XCUIElementTypeTextField[@value\='Ricard']
${pres_checkbox_first_line}     //XCUIElementTypeStaticText[@value\=''][1]
${box_checkbox_first_line}      //XCUIElementTypeStaticText[@value\=''][2]

# OTHERS_TASKS
${field_qte_relevee_contains_ricard}                        //XCUIElementTypeStaticText[contains(@value, 'RIC')][1]/following-sibling::XCUIElementTypeStaticText[1]
${field_qte_ajoutee_contains_ricard}                        //XCUIElementTypeStaticText[contains(@value, 'RIC')][1]/following-sibling::XCUIElementTypeTextField[1]
${field_qte_totale_contains_ricard}                         //XCUIElementTypeStaticText[contains(@value, 'RIC')][1]/following-sibling::XCUIElementTypeStaticText[2]

# BUSINESS_OPERATION
${ending_date_prospectus}       (//XCUIElementTypeStaticText[contains(@value, 'au')])[2]

# VISIT_SYNTHESE
${visit_date_and_hour_element}                              //XCUIElementTypeStaticText[contains(@value, 'Visite prévue')]
${pvc_and_facing_fields_xpath}                              (//XCUIElementTypeTextField)
${priorite_business_filter_important_checkbox}              //XCUIElementTypeStaticText[@value\='Important']/../following-sibling::XCUIElementTypeSwitch
${priorite_business_filter_secondaire_checkbox}             //XCUIElementTypeStaticText[@value\='Secondaire']/../following-sibling::XCUIElementTypeSwitch
${agreement_MEA_title}          //XCUIElementTypeStaticText[@value\='Constaté MEA']/ancestor::XCUIElementTypeOther/preceding-sibling::XCUIElementTypeStaticText[contains(@value,'Accord # PA-')][1]
${cell_op_trade_name_MEA_pastis_51}                         //XCUIElementTypeStaticText[contains(@value, 'MEA PASTIS 51')]
${agreement_MEA_pastis_51_quota_cell}                       ${cell_op_trade_name_MEA_pastis_51}/following-sibling::XCUIElementTypeStaticText[3]
${agreement_status}             //XCUIElementTypeStaticText[@value\='STATUT']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeStaticText
${save_button}                  //XCUIElementTypeButton[@name\='ENREGISTRER']

# VISIT_OBJECTIVES
${last_visit_report_field}      //XCUIElementTypeStaticText[contains(@value, 'Consulter le compte-rendu du')]/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther/XCUIElementTypeStaticText
${visit_type_field}             //XCUIElementTypeStaticText[@value\='Type de visite:']/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeStaticText
${action_pvc_constate_comments_button}                      //XCUIElementTypeStaticText[@value\='Action PVC constaté']/following-sibling::XCUIElementTypeOther[2]/XCUIElementTypeStaticText[@value\='Consulter les commentaires']
${action_dn_comments_button}    //XCUIElementTypeStaticText[@value\='Action DN']/following-sibling::XCUIElementTypeOther[2]/XCUIElementTypeStaticText[@value\='Consulter les commentaires']
${other_tasks_comment_field}    //XCUIElementTypeStaticText[@value\='Commentaire:']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeStaticText

# VALIDATION_OF_OBJECTIVES
${action_dn_checkbox}           //XCUIElementTypeStaticText[@name\='Action DN']/following-sibling::XCUIElementTypeStaticText[1]
${action_pvc_constate_checkbox}                             //XCUIElementTypeStaticText[@name\='Action PVC constaté']/following-sibling::XCUIElementTypeStaticText[1]
${controle_des_contacts_checkbox}                           //XCUIElementTypeStaticText[@name\='Contrôle des contacts']/following-sibling::XCUIElementTypeStaticText[1]
${fourth_other_task}            //XCUIElementTypeStaticText[@name\='AUTRES TÂCHES PRÉVUES']/following-sibling::XCUIElementTypeOther/XCUIElementTypeStaticText[7]
${fourth_other_task_checkbox}                               ${fourth_other_task}/following-sibling::XCUIElementTypeStaticText[@value\='']

# MEA_CREATION
${BRI_input_field}              //XCUIElementTypeTextField
${first_line_PASTIS_51}         (//XCUIElementTypeStaticText[contains(@name, 'PASTIS 51')])[1]/following-sibling::XCUIElementTypeOther/XCUIElementTypeTextField
${first_line_mea_pirate}        (//XCUIElementTypeStaticText[@name\='ARTICLES']/following-sibling::XCUIElementTypeOther/XCUIElementTypeTextField)
${field_quantite_negocie_first_line_PASTIS_51_accord}       ((//XCUIElementTypeStaticText[contains(@name, 'PASTIS 51')])[2]/following-sibling::XCUIElementTypeOther/XCUIElementTypeTextField)[1]

# VENTE_ANIMEE
${first_line_product_ricard_VA}                             //XCUIElementTypeStaticText[contains(@value, 'RICARD')][1]
${field_objectif_de_vente_VA}                               ${first_line_product_ricard_VA}/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeTextField
${field_objectif_de_degustation_VA}                         ${first_line_product_ricard_VA}/following-sibling::XCUIElementTypeOther[3]/XCUIElementTypeTextField

# VISIT_CLOSING
${finish_visit_button}          //XCUIElementTypeButton[@name\='TERMINER LA VISITE']

# MY_ACCOUNT
${visit_in_progress_error_message}                          //XCUIElementTypeStaticText[@value\='Une visite est déjà en cours']
${confirmation_button}          //XCUIElementTypeButton[@name\='OK']
${confirmation_button_synch}    //XCUIElementTypeButton[@name\='CONTINUER']

# NEW_ORDER
${field_client}                 //XCUIElementTypeStaticText[@value\='CLIENT']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
${field_order_type}             //XCUIElementTypeStaticText[@value\='TYPE DE COMMANDE']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
${field_delivery_details}       //XCUIElementTypeStaticText[@value\='INSTRUCTIONS DE LIVRAISON']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeTextField[1]
${field_delivery_date}          //XCUIElementTypeStaticText[@value\='DATE DE LIVRAISON']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
${field_delivery_hour}          //XCUIElementTypeStaticText[@value\='HEURE DE LIVRAISON']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
${validate_button}              //XCUIElementTypeButton[@name\='VALIDER']
${field_delivery_address}       //XCUIElementTypeStaticText[@value\='ADRESSE DE LIVRAISON']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeTextField[1]
${field_delivery_contact}       //XCUIElementTypeStaticText[@value='CONTACT DE LIVRAISON']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
${first_delivery_contact_option}                            //XCUIElementTypeTextField[@value\='Chercher']/following-sibling::XCUIElementTypeOther[1]
${radio_button_oui}             //XCUIElementTypeStaticText[@value\='Oui']
${field_delivery_phone}         //XCUIElementTypeStaticText[@value\='TÉLÉPHONE DE LIVRAISON']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeTextField[1]
${field_comment}                //XCUIElementTypeStaticText[@value\='COMMENTAIRE']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeTextField[1]
${field_furniture_reference}    //XCUIElementTypeStaticText[@value\='RÉFÉRENCE']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]
${first_reference_with_quota}                               (//XCUIElementTypeStaticText[contains(@value,'Quota(s) disponible(s) :')])[1]
${furniture_order_retail_store_option}                      //XCUIElementTypeStaticText[@value\='${furniture_order_retail_store}']

*** Keywords ***
Start Suite Mobile
    LoadConfig                  ${CURDIR}${/}..${/}configs${/}local_app.yaml
    Set Library Search Order    QMobile                     QForce
    SetConfig                   DefaultTimeout              15
    SetConfig                   iosvisible                  false
    Log Variables
    OpenApp
    Run Keyword If              not ${is_env_set_up}        Select Mobile App Environment                           ${env}


End Suite Mobile
    CloseAllApplications


Login Page
    ${logged_in}=               IsIcon                      neo_logo                    match_threshold=0.5         timeout=5
    Run Keyword If              ${logged_in}                Log Out


Home
    ${logged_in}=               IsIcon                      neo_logo                    match_threshold=0.5         timeout=5
    Run Keyword If              not ${logged_in}            Log In
    ClickMenu                   ACCUEIL


Log In
    ClickPoint                  100                         100                         #Click at a random point of the screen in case an input field is selected

    Click Field And Fill Value                              ${login_username_field}     ${username}
    Click Field And Fill Value                              ${login_password_field}     ${password}

    ClickText                   Log In to Sandbox
    ${is_saved_passwords_popup_displayed}=                  IsText                      Touch ID                    timeout=5

    IF                          ${is_saved_passwords_popup_displayed}
        ClickText               Cancel
        ClickText               Log In to Sandbox
    END

    ${is_access_popup_displayed}=                           IsText                      Autoriser l'accès ?         timeout=5
    Run Keyword If              ${is_access_popup_displayed}                            ClickElement                ${confirmation_button_access}
    ${is_location_popup_displayed}=                         IsText                      your location?              timeout=5
    Run Keyword If              ${is_location_popup_displayed}                          ClickText                   Allow While Using App

    VerifyIcon                  neo_logo                    timeout=600                 #10min


Select Mobile App Environment
    [Arguments]                 ${environment}
    Login Page
    ClickItem                   choose connection button

    Run Keyword If              '${environment}'=='staging'                             ClickText                   Staging
    Run Keyword If              '${environment}'=='prfsb2full'                          ClickText                   prfsb2full

    Wait Until Keyword Succeeds                             10 sec                      2                           VerifyText                  Log In to Sandbox
    Set Global Variable         ${is_env_set_up}            True


Log Out
    #ClickCoordinate            1131                        54
    ClickIcon                   user_icon
    VerifyText                  Salesbook
    ClickText                   ME DECONNECTER
    VerifyText                  Attention
    ClickText                   Se déconnecter
    VerifyText                  Log In


ClickMenu
    [Arguments]                 ${button}
    ClickElement                //*[@value\='${button}']/../XCUIElementTypeStaticText[3]
    Run Keyword And Continue On Failure                     ClickText                   ${button}


Navigate To Visit Step
    [Arguments]                 ${visit_step}
    IF                          '${visit_step}' == '1'
        ClickCoordinate         98                          126
    ELSE IF                     '${visit_step}' == '2'
        ClickCoordinate         295                         126
    ELSE IF                     '${visit_step}' == '3'
        ClickCoordinate         492                         126
    ELSE IF                     '${visit_step}' == '4'
        ClickCoordinate         688                         126
    ELSE IF                     '${visit_step}' == '5'
        ClickCoordinate         885                         126
    ELSE IF                     '${visit_step}' == '6'
        ClickCoordinate         1081                        126
    END


VerifyPage
    [Arguments]                 ${page}
    IF                          '${page}'=='LOGIN'
        Run Keyword And Continue On Failure                 VerifyText                  Username
        Run Keyword And Continue On Failure                 VerifyText                  Password
        Run Keyword And Continue On Failure                 VerifyText                  Log In to Sandbox
        Run Keyword And Continue On Failure                 VerifyText                  Remember me
        Run Keyword And Continue On Failure                 VerifyText                  Forgot Your Password?
        Run Keyword If          '${env}'=='staging'         Run Keyword And Continue On Failure                     VerifyText                  Log in with Pernod Ricard SSO

    ELSE IF                     '${page}'=='PASSWORD_RECOVERY'
        Run Keyword And Continue On Failure                 VerifyText                  Having trouble logging in?
        Run Keyword And Continue On Failure                 VerifyText                  Username
        Run Keyword And Continue On Failure                 VerifyText                  Continue

    ELSE IF                     '${page}'=='ACTIVITY_DAY'
        Run Keyword And Continue On Failure                 VerifyText                  MES ACTIVITÉS
        Run Keyword And Continue On Failure                 VerifyText                  MA JOURNÉE
        Run Keyword And Continue On Failure                 VerifyText                  MA SEMAINE
        Run Keyword And Continue On Failure                 VerifyText                  MES VISITES DU JOUR
        Run Keyword And Continue On Failure                 VerifyText                  MES AUTRES ÉVÈNEMENTS
        Run Keyword And Continue On Failure                 VerifyText                  VOIR SUR LA CARTE
        Run Keyword And Continue On Failure                 VerifyText                  CRÉER UNE ACTIVITÉ

    ELSE IF                     '${page}'=='ACTIVITY_WEEK'
        Run Keyword And Continue On Failure                 VerifyText                  MES ACTIVITÉS
        Run Keyword And Continue On Failure                 VerifyText                  MA JOURNÉE
        Run Keyword And Continue On Failure                 VerifyText                  MA SEMAINE
        Run Keyword And Continue On Failure                 VerifyText                  Type de visite
        Run Keyword And Continue On Failure                 VerifyText                  Statut visite
        Run Keyword And Continue On Failure                 VerifyText                  Sans week-end
        Run Keyword And Continue On Failure                 VerifyText                  CRÉER UNE ACTIVITÉ

    ELSE IF                     '${page}'=='ORDERS'
        Verify Menu Buttons

        Run Keyword And Continue On Failure                 VerifyText                  OP / COMMANDES / CONTRATS
        Run Keyword And Continue On Failure                 VerifyText                  Sélectionner un client
        Run Keyword And Continue On Failure                 VerifyText                  LISTE DES COMMANDES
        Run Keyword And Continue On Failure                 VerifyText                  ACCORDS
        Run Keyword And Continue On Failure                 VerifyText                  MARCHÉS
        Run Keyword And Continue On Failure                 VerifyText                  ACC
        Run Keyword And Continue On Failure                 VerifyText                  OP TRADE
        Run Keyword And Continue On Failure                 VerifyText                  PROMO ENSEIGNE
        Run Keyword And Continue On Failure                 VerifyText                  Filtrer

    ELSE IF                     '${page}'=='VISIT_SYNTHESE'

        Run Keyword And Continue On Failure                 Check If Visit Has Been Planned And Verify Text         ${BP_visit_name}            ${BP_visit_name}
        Run Keyword And Continue On Failure                 Check If Visit Has Been Planned And Verify Text         ${BP_visit_name}            ${BP_visit_address}

        ${date_and_hour}=       GetValue                    xpath\=${visit_date_and_hour_element}                   attribute=value
        ${expected_pattern}=    SetVariable                 Visite prévue : (\d{2}/\d{2}/\d{4} \d{1,2}:\d{2} [APap][Mm])                        # Define the regular expression pattern for date and hour
        Run Keyword And Continue On Failure                 VerifyText                  ${date_and_hour}            matches=${expected_pattern}                 # Verify the extracted text matches the expected pattern

        #MENU
        Run Keyword And Continue On Failure                 VerifyText                  SYNTHÉSE
        Run Keyword And Continue On Failure                 VerifyText                  PERFECT STORE
        Run Keyword And Continue On Failure                 VerifyText                  ASSORTIMENTS / PVA
        Run Keyword And Continue On Failure                 VerifyText                  POTENTIEL CLIENT
        Run Keyword And Continue On Failure                 VerifyText                  INFORMATIONS PDV
        Run Keyword And Continue On Failure                 VerifyText                  ACCORDS
        Run Keyword And Continue On Failure                 VerifyText                  PLAN DE VENTE

        #KPI
        Run Keyword And Continue On Failure                 VerifyText                  IDENTITÉ
        Run Keyword And Continue On Failure                 VerifyText                  DISPONIBILITÉ
        Run Keyword And Continue On Failure                 VerifyText                  VISIBILITÉ
        Run Keyword And Continue On Failure                 VerifyText                  PVC
        Run Keyword And Continue On Failure                 VerifyText                  ACTIVATION
        Run Keyword And Continue On Failure                 VerifyText                  INNOVATION
        Run Keyword And Continue On Failure                 VerifyText                  RUPTURE
        Run Keyword And Continue On Failure                 VerifyText                  ELIGIBILITÉ ET HABILLAGE

    ELSE IF                     '${page}'=='VISIT_STEP_1'
        Verify Header Visit Steps

        Run Keyword And Continue On Failure                 VerifyText                  Consulter le compte-rendu du
        Run Keyword And Continue On Failure                 VerifyText                  Type de visite:
        Run Keyword And Continue On Failure                 VerifyText                  ACTIONS PRIORITAIRES
        Run Keyword And Continue On Failure                 VerifyText                  Objectif BP 1
        Run Keyword And Continue On Failure                 VerifyText                  Objectif BP 2
        Run Keyword And Continue On Failure                 VerifyText                  Avec réimplantation

        ${visit_type}=          GetValue                    xpath\=//XCUIElementTypeStaticText[@value\='Type de visite:']/parent::XCUIElementTypeOther/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeStaticText    attribute=value
        Set Global Variable     ${visit_type}

    ELSE IF                     '${page}'=='VISIT_STEP_2'
        Verify Header Visit Steps

        Run Keyword And Continue On Failure                 VerifyText                  Rechercher par nom de produit / code EAN / code interne
        Run Keyword And Continue On Failure                 VerifyText                  Filtrer
        Run Keyword And Continue On Failure                 VerifyText                  PRIORITÉ BUSINESS
        Run Keyword And Continue On Failure                 VerifyText                  Anomalies:
        Run Keyword And Continue On Failure                 VerifyText                  Segment
        Run Keyword And Continue On Failure                 VerifyText                  Marque
        Run Keyword And Continue On Failure                 VerifyText                  Statut
        Run Keyword And Continue On Failure                 VerifyText                  Nom du produit / Code EAN / Code interne
        Run Keyword And Continue On Failure                 VerifyText                  Oblig.
        Run Keyword And Continue On Failure                 VerifyText                  Ref.
        Run Keyword And Continue On Failure                 VerifyText                  PVC
        Run Keyword And Continue On Failure                 VerifyText                  Facings
        Run Keyword And Continue On Failure                 VerifyText                  Niv min.
        Run Keyword And Continue On Failure                 VerifyText                  Niv max.
        Run Keyword And Continue On Failure                 VerifyText                  RUPTURE

        Swipe                   start_x=1000                start_y=500                 offset_x=-500               offset_y=0
        Run Keyword And Continue On Failure                 Verify Text                 Box
        Swipe                   start_x=100                 start_y=500                 offset_x=500                offset_y=500

        Run Keyword And Continue On Failure                 VerifyText                  AJOUTER UNE RÉFÉRENCE
        Run Keyword And Continue On Failure                 VerifyText                  JOINDRE UNE PHOTO
        Run Keyword And Continue On Failure                 VerifyText                  RÉORGANISER REF

    ELSE IF                     '${page}'=='VISIT_STEP_3'
        Verify Header Visit Steps

        Run Keyword And Continue On Failure                 VerifyText                  MES RELEVÉS
        Run Keyword And Continue On Failure                 VerifyText                  MES QUESTIONNAIRES

    ELSE IF                     '${page}'=='VISIT_STEP_3_RELEVÉ_PDL'
        Verify Header Visit Steps

        Run Keyword And Continue On Failure                 VerifyText                  RELEVÉ PDL

        Run Keyword And Continue On Failure                 VerifyText                  ALCOOLS
        Run Keyword And Continue On Failure                 VerifyText                  Catégorie
        Run Keyword And Continue On Failure                 VerifyText                  Linéaire
        Run Keyword And Continue On Failure                 VerifyText                  Part de linéaire
        Run Keyword And Continue On Failure                 VerifyText                  Anisés
        Run Keyword And Continue On Failure                 VerifyText                  Rhums
        Run Keyword And Continue On Failure                 VerifyText                  Whiskies
        Run Keyword And Continue On Failure                 VerifyText                  Total Alcools

        Run Keyword And Continue On Failure                 VerifyText                  HARD SELTZER
        Run Keyword And Continue On Failure                 VerifyText                  Total Bières

        Swipe                   start_x=500                 start_y=500                 offset_x=0                  offset_y=0

        Run Keyword And Continue On Failure                 VerifyText                  Champagne GMI
        Run Keyword And Continue On Failure                 VerifyText                  Catégorie
        Run Keyword And Continue On Failure                 VerifyText                  Linéaire
        Run Keyword And Continue On Failure                 VerifyText                  Part de linéaire
        Run Keyword And Continue On Failure                 VerifyText                  Total Champagne

    ELSE IF                     '${page}'=='VISIT_STEP_3_RELEVÉ__MOYEN_PDL'
        Run Keyword And Continue On Failure                 VerifyText                  MES AUTRES ACTIONS
        Run Keyword And Continue On Failure                 VerifyText                  Rechercher un moyen
        Run Keyword And Continue On Failure                 VerifyText                  Marque
        Run Keyword And Continue On Failure                 VerifyText                  Moyen
        Run Keyword And Continue On Failure                 VerifyText                  Qté relevée
        Run Keyword And Continue On Failure                 VerifyText                  Qté ajoutée
        Run Keyword And Continue On Failure                 VerifyText                  Qté totale

    ELSE IF                     '${page}'=='VISIT_STEP_4'
        Verify Header Visit Steps

        Run Keyword And Continue On Failure                 VerifyText                  PROMO ENSEIGNE
        Run Keyword And Continue On Failure                 VerifyText                  ACCORDS
        Run Keyword And Continue On Failure                 VerifyText                  BOOK PROMO SALESBOOK
        Run Keyword And Continue On Failure                 VerifyText                  Rechercher une opération
        Run Keyword And Continue On Failure                 VerifyText                  Filtrer
        Run Keyword And Continue On Failure                 VerifyText                  Nom de l’opération
        Run Keyword And Continue On Failure                 VerifyText                  Accords associés
        Run Keyword And Continue On Failure                 VerifyText                  Code TPM
        Run Keyword And Continue On Failure                 VerifyText                  Type promo
        Run Keyword And Continue On Failure                 VerifyText                  Type d’action
        Run Keyword And Continue On Failure                 VerifyText                  Remontée commande
        Run Keyword And Continue On Failure                 VerifyText                  Prospectus
        Run Keyword And Continue On Failure                 VerifyText                  Centrale
        Run Keyword And Continue On Failure                 VerifyText                  CRÉER UN ACCORD

    ELSE IF                     '${page}'=='VISIT_STEP_5'
        Verify Header Visit Steps

        Run Keyword And Continue On Failure                 VerifyText                  NOTE PERFECT STORE
        Run Keyword And Continue On Failure                 VerifyText                  RICARD
        Run Keyword And Continue On Failure                 VerifyText                  Type de visite:
        Run Keyword And Continue On Failure                 VerifyText                  ACTIONS PRIORITAIRES
        Run Keyword And Continue On Failure                 VerifyText                  Objectif BP 1
        Run Keyword And Continue On Failure                 VerifyText                  Objectif BP 2
        Run Keyword And Continue On Failure                 VerifyText                  Avec réimplantation
        Run Keyword And Continue On Failure                 VerifyText                  ACTIONS PRIORITAIRES
        Run Keyword And Continue On Failure                 VerifyText                  Depuis la dernière visite
        Run Keyword And Continue On Failure                 VerifyText                  /100

    ELSE IF                     '${page}'=='VISIT_STEP_6'
        Verify Header Visit Steps

        Run Keyword And Continue On Failure                 VerifyText                  Consulter le compte-rendu du
        Run Keyword And Continue On Failure                 VerifyText                  CLÔTURE DE LA VISITE
        Run Keyword And Continue On Failure                 VerifyText                  Saisir le compte-rendu
        Run Keyword And Continue On Failure                 VerifyText                  Joindre le plan de vente
        Run Keyword And Continue On Failure                 VerifyText                  ENVOYER PAR MAIL
        Run Keyword And Continue On Failure                 VerifyText                  REPLANIFIER UNE VISITE
        Run Keyword And Continue On Failure                 VerifyText                  TERMINER LA VISITE

    END


Verify Menu Buttons
    Run Keyword And Continue On Failure                     VerifyText                  ACCUEIL
    Run Keyword And Continue On Failure                     VerifyText                  ACTIVITÉS
    Run Keyword And Continue On Failure                     VerifyText                  COMMANDES
    Run Keyword And Continue On Failure                     VerifyText                  CLIENTS
    Run Keyword And Continue On Failure                     VerifyText                  PRODUITS


Verify Header Visit Steps
    Run Keyword And Continue On Failure                     VerifyText                  Objectifs de visite
    Run Keyword And Continue On Failure                     VerifyText                  Relevé 4P
    Run Keyword And Continue On Failure                     VerifyText                  Autres actions
    Run Keyword And Continue On Failure                     VerifyText                  Opérations commerciales
    Run Keyword And Continue On Failure                     VerifyText                  Validation des objectifs
    Run Keyword And Continue On Failure                     VerifyText                  Clôture de la visite


VerifyCalendar
    [Arguments]                 ${weekend_display}
    Run Keyword And Continue On Failure                     VerifyText                  Lundi
    Run Keyword And Continue On Failure                     VerifyText                  Mardi
    Run Keyword And Continue On Failure                     VerifyText                  Mercredi
    Run Keyword And Continue On Failure                     VerifyText                  Jeudi
    Run Keyword And Continue On Failure                     VerifyText                  Vendredi

    Run Keyword If              ${weekend_display}          VerifyText                  Samedi
    Run Keyword If              ${weekend_display}          VerifyText                  Dimanche


Check If Visit Has Been Planned And Search And Add Reference
    [Arguments]                 ${visit_text}               ${reference}
    ${has_visit_been_planned}                               Run Keyword And Return Status                           Should not Be Empty         ${visit_text}
    Run Keyword If              ${has_visit_been_planned}                               Search and Add Reference    ${reference}                ${visit_text}
    ...                         ELSE                        Log                         Visit has not been planned, skipping action


Search And Add Reference
    [Arguments]                 ${ProductName}              ${SectionName}
    IF                          ${SectionName}
        ClickText               Rechercher par nom de produit
        WriteText               ${ProductName}
        HideKeyboard
        ${IsProductInList}=     Run Keyword and Return Status                           VerifyElement               //XCUIElementTypeStaticText[@value\='${ProductName}']     timeout=5

        #Add Reference if Product doesn't exist in list
        IF                      ${IsProductInList}==False
            ClickText           AJOUTER UNE RÉFÉRENCE
            ClickText           Rechercher par nom de produit
            WriteText           ${ProductName}\n
            HideKeyboard
            ${IsProductInReferences}=                       Run Keyword and Return Status                           VerifyElement               //XCUIElementTypeStaticText[@value\='${ProductName}']    timeout=5

            IF                  ${IsProductInReferences}
                ClickElement    //XCUIElementTypeImage[@name\='img']/following-sibling::XCUIElementTypeStaticText[@value\='${ProductName}']
                ClickText       AJOUTER                     case_sensitive=true
            END

        END

    END


Check If Visit Has Been Planned And Click Visit
    [Arguments]                 ${visit_text}
    ${has_visit_been_planned}                               Run Keyword And Return Status                           Should Not Be Empty         ${visit_text}
    Run Keyword If              ${has_visit_been_planned}                               Click Planned Visit         ${visit_text}
    ...                         ELSE                        Click Random Planned Visit


Click Planned Visit
    [Arguments]                 ${visit_text}
    ClickText                   ${visit_text}


Click Random Planned Visit
    ClickText                   SCORE


Check If Visit Has Been Planned And Verify Text
    [Arguments]                 ${visit_text}               ${text_to_verify}
    ${has_visit_been_planned}                               Run Keyword And Return Status                           Should Not Be Empty         ${visit_text}
    Run Keyword If              ${has_visit_been_planned}                               VerifyText                  ${text_to_verify}


Synch App Data
    ClickIcon                   refresh
    VerifyText                  Sync
    ClickText                   SYNCHRONISER MAINTENANT


Click And Fill Elements With Incremented Index
    [Arguments]                 ${base_xpath}               ${max_index}
    FOR                         ${index}                    IN RANGE                    2                           ${max_index}+1
        ${initial_value}=       GetText                     ${base_xpath}               index=${index}              timeout=5
        ${is_initial_value_null}                            Run Keyword And Return Status                           Should Be Empty             ${initial_value}

        IF                      ${is_initial_value_null}
            ClickElement        ${base_xpath}               index=${index}

            ${index_is_even} =                              Evaluate                    ${index} % 2 == 0
            IF                  ${index_is_even}
                WriteText       37,0                        clear=false                 #PVC field
            ELSE
                WriteText       2                           clear=false                 #Facing field
            END
            HideKeyboard
        END

        HideKeyboard
    END


Click And Fill Levels
    [Arguments]                 ${icon}
    ${is_level_empty}           Run Keyword And Return Status                           IsIcon                      ${icon}

    WHILE                       ${is_level_empty}
        Run Keyword And Ignore Error                        ClickIcon                   dropdown_button             timeout=2
        ClickText               2
        Refresh Bug List
        ClickElement            ${button_next}
        ${is_level_empty}       IsIcon                      ${icon}                     match_threshold=1           timeout=2
        ${is_text_mes_releves}=                             IsText                      MES RELEVÉS

        IF                      ${is_text_mes_releves}
            Navigate To Visit Step                          2
            Sleep               3
        END

    END


Refresh List
    [Arguments]                 ${toggle_switch}
    ClickElement                ${toggle_switch}
    Sleep                       1
    ClickElement                ${toggle_switch}


Refresh Bug List
    Refresh List                ${bug_switch}


Clear Search Bar
    ${is_search_bar_filled}     Run Keyword And Return Status                           VerifyIcon                  clear_search_bar_button
    Run Keyword If              ${is_search_bar_filled}     ClickIcon                   clear_search_bar_button


Click Field And Fill Value
    [Arguments]                 ${locator}                  ${text}
    ClearText                   ${locator}
    InputText                   ${locator}                  ${text}
    Hide Keyboard
    ClickCoordinate             0                           0


Click Element If Visible
    [Arguments]                 ${element}
    ${is_element_visible}=      Run Keyword And Return Status                           Element Should Be Visible                               ${element}
    Run Keyword If              ${is_element_visible}       Wait Until Keyword Succeeds                             1min                        5               ClickElement    ${element}


Reference Product Should Be Equal
    [Arguments]                 ${priority_action}
    ${product_displayed}=       Get Element Attribute       locator=//XCUIElementTypeStaticText[@value\='${priority_action}']/ancestor::XCUIElementTypeOther[1]/following-sibling::XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeStaticText[1]    attribute=value
    Log To Report And Console                               product_displayed           ${product_displayed}

    Set Suite Variable          ${ref_produit_checked}      ${ref_produit_checked_${priority_action}}
    Log To Report And Console                               ref_produit_checked         ${ref_produit_checked}

    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${ref_produit_checked}      ${product_displayed}


Check Visit Objectives
    ${visit_type}=              GetValue                    xpath\=${visit_type_field}                              attribute=value
    Set Global Variable         ${visit_type}

    Scroll Down To The Bottom Of The Page

    IF                          '${visit_type}' != 'Hors Business Planning'
        Run Keyword If          ${is_innovations_manquantes_checked}                    Reference Product Should Be Equal                       INNOVATIONS MANQUANTES
        Run Keyword If          ${is_references_obligatoires_manquantes_checked}        Reference Product Should Be Equal                       RÉFÉRENCES OBLIGATOIRES MANQUANTES
        Run Keyword If          ${is_references_additionnelles_manquantes_checked}      Reference Product Should Be Equal                       RÉFÉRENCES ADDITIONNELLES MANQUANTES
        Run Keyword If          ${is_rupture_sur_les_6_derniers_mois_checked}           Reference Product Should Be Equal                       RUPTURE SUR LES 6 DERNIERS MOIS
        Run Keyword If          ${is_promo_en_cours_checked}                            Reference Product Should Be Equal                       PROMOTIONS EN COURS
    END

    VerifyText                  Action DN
    VerifyText                  Action PVC constaté
    VerifyText                  Négo visibilité


Check Other Tasks Comments
    IF                          ${is_HBP_visit_planned} or ${is_BP_visit_planned}
        ClickElement            ${action_pvc_constate_comments_button}
        Verify Other Task Comment                           ${random_string_action_pvc_constate}

        ClickElement            ${action_dn_comments_button}
        Verify Other Task Comment                           ${random_string_action_dn}
    END


Verify Other Task Comment
    [Arguments]                 ${text_previously_commented}
    ${comments_text}=           GetValue                    xpath\=${other_tasks_comment_field}                     value
    Run Keyword And Continue On Failure                     Should Be Equal             ${text_previously_commented}                            ${comments_text}
    ClickText                   Fermer


Scroll Down To The Bottom Of The Page
    ${scrollBar_size}=          Get element size            Vertical scroll bar, 1 page                             #Getting scroll bar size
    ${swipe_height}=            Evaluate                    ${scrollBar_size}[height]-40
    Swipe                       0                           ${swipe_height}             0                           0


Check If Field is Empty And Fill It                       
    [Arguments]                 ${field_xpath}              ${new_value}
    ${value}=                   GetText                     ${field_xpath}
    ${is_value_empty}=          Run Keyword And Return Status                           Should Be Empty             ${value}
    Fill Field with Value       ${field_xpath}              ${new_value}


Fill Field with Value
    [Arguments]                 ${field_xpath}              ${value}
    ClickElement                ${field_xpath}
    WriteText                   ${value}                    clear=false
    HideKeyboard
    ClickText                   PVC


Verify Agreement Cell Value And Status And Fill Next Cell
    [Arguments]                 ${cell_to_verify}

    IF                          '${cell_to_verify}'=='1'
        ${value_agreement_status}=                          SetVariable                 Négocié MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_qte_negociee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_TG_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='2'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_TG_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_flagship_multimarque_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='3'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_flagship_multimarque_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_BG_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='4'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_BG_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_flagship_marque_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='5'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_flagship_marque_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_ilot_promo_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='6'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_ilot_promo_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_meuble_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='7'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_meuble_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_promotainer_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='8'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_promotainer_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_presentoir_reutilisable_qte_constatee_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='9'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_presentoir_reutilisable_qte_constatee_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_qte_gratuite_PASTIS_51}
    ELSE IF                     '${cell_to_verify}'=='10'
        ${value_agreement_status}=                          SetVariable                 Constaté MEA
        ${value_cell_to_verify}=                            SetVariable                 ${value_qte_gratuite_PASTIS_51}
        ${value_cell_to_fill}=                              SetVariable                 ${value_TG_qte_constatee_PASTIS_51}
    END

    ${cell_to_fill}=            Evaluate                    ${cell_to_verify}+1

    ClickText                   Nouvel accord

    Swipe By Percent            50                          20                          50                          66
    VerifyText                  MEA Pirate

    ${value_agreement_status_displayed}=                    GetValue                    xpath\=${agreement_status}                              value
    Run Keyword And Continue On Failure                     Should Be Equal As Strings                              ${value_agreement_status_displayed}         ${value_agreement_status}

    Swipe By Percent            50                          20                          50                          0
    ${value_displayed_cell_to_verify}=                      GetText                     ${first_line_mea_pirate}\[${cell_to_verify}\]
    Run Keyword And Continue On Failure                     Should Be Equal             ${value_displayed_cell_to_verify}                       ${value_cell_to_verify}

    IF                          ${cell_to_verify} < 10
        ClickElement            ${first_line_mea_pirate}\[${cell_to_fill}\]
        WriteText               ${value_cell_to_fill}       clear=false
        HideKeyboard
        HideKeyboard
        ClickElement            ${save_button}
    ELSE
        ClickIcon               close
    END