*** Settings ***
Library                     String
Library                     QForce
Library                     DateTime
Resource                    secret.robot

*** Variables ***
# Execution parameters
${env}                      prfsb2full
${BP_visit_goal}            Perfect Store               #Accepted value: Perfect Store, MEP prospectus, Remontée de commande, Couverture PDV
${value_qte_negociee_PASTIS_51}                         7
${value_TG_qte_constatee_PASTIS_51}                     8
${value_flagship_multimarque_qte_constatee_PASTIS_51}                               9
${value_BG_qte_constatee_PASTIS_51}                     10
${value_flagship_marque_qte_constatee_PASTIS_51}        11
${value_ilot_promo_qte_constatee_PASTIS_51}             12
${value_meuble_qte_constatee_PASTIS_51}                 13
${value_promotainer_qte_constatee_PASTIS_51}            14
${value_presentoir_reutilisable_qte_constatee_PASTIS_51}                            15
${value_qte_gratuite_PASTIS_51}                         16
${value_BRI_PASTIS_51}      2
${value_pvc}                19,87
${value_facing}             7
${value_objectif_de_vente_VA}                           5
${value_objectif_de_degustation_VA}                     5
${delivery_details}         Déposer à l'accueil
${furniture_order_retail_store}                         INTERMARCH

# Global variables
${is_env_set_up}            False
${date_today}
${is_visit_prepared}        False
${BP_visit_name}
${BP_visit_address}
${BP_visit_type_displayed}
${is_BP_visit_planned}      False
${HBP_visit_name}
${HBP_visit_type_displayed}
${is_HBP_visit_planned}     False
${random_string_action_pvc_constate}
${random_string_action_dn}
${agreement_MEA_ref}
${OP_trade_name_MEA_pastis_51}
${value_OP_trade_quota}
${is_Innovation_visible}
${reference_produit_innovations_manquantes}
${value_delivery_hour}
${value_delivery_date}
${value_delivery_address}
${value_delivery_contact}
${value_delivery_phone}
${random_string_furniture_order_comment}
${is_innovations_manquantes_checked}                    False
${is_references_obligatoires_manquantes_checked}        False
${is_references_additionnelles_manquantes_checked}      False
${is_rupture_sur_les_6_derniers_mois_checked}           False
${is_promo_en_cours_checked}                            False
${is_element_with_quota_displayed}                      False

*** Keywords ***
Log To Report And Console
    [Arguments]             ${variable_name}            ${variable}
    Log                     "${variable_name}" is now: ${variable}                  console=yes


Generate Random String With Date
    [Arguments]             ${length_of_random_string}
    ${random_string}=       Generate Random String      ${length_of_random_string}
    ${date}=                Get Today's Date            %a %B %d %H:%M:%S UTC %Y
    [Return]                ${date} - random: ${random_string}


Get Today's Date 
    [Arguments]             ${result_format}
    ${date}=                Get Current Date            UTC                         exclude_millis=yes
    ${convert}=             Convert Date                ${date}                     result_format=${result_format}
    [Return]                ${convert}


Convert Date Format
    [Arguments]             ${original_date}
    ${converted_date}       Convert Date                ${original_date}            result_format=%d/%m/%y
    [Return]                ${converted_date}


Remove Undesired String
    [Arguments]             ${input_string}             ${remove_string}
    ${desired_value}=       Strip String                ${input_string}             characters=${remove_string}
    [Return]                ${desired_value}


Set Global Variable from Element  
    [Arguments]             ${element}                  ${variable}
    ${element_text}         Get Text                    ${element}
    Set Global Variable     ${variable}                 ${element_text}


Extract Numbers From String
    [Arguments]             ${input_string}
    ${matches}=             Get Regexp Matches          ${input_string}             \\d+
    ${string_numbers}=      Evaluate                    ', '.join($matches)
    ${numbers}=             Convert To Integer          ${string_numbers}
    [Return]                ${numbers}


Verify String Is A Date
    [Arguments]             ${date_string}
    ${expected_format}=     Set Variable                ^([0-2][0-9]|(3)[0-1])\/(((0)[0-9])|((1)[0-2]))\/20[0-9]{2}$
    Should Match Regexp     ${date_string}              ${expected_format}


E2E Check Previous Step Status
    [Arguments]             ${is_previous_step_success}
    Run Keyword If          not ${is_previous_step_success} == True                 FatalError                  Previous step of the End-to-end scenario not completed.