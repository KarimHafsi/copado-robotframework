*** Settings ***
Resource                        ../resources/web.robot
Suite Setup                     Start Suite
Suite Teardown                  End Suite

*** Test Cases ***
Check Promotion Agreement List Page UI Elements
    [Documentation]             Checking UI Elements for Promotion Agreement List Page
    [Tags]                      NEO-10236                   UI
    Appstate                    Home
    Navigate To Page            PROMOTION_AGREEMENT_LIST
    VerifyPage                  PROMOTION_AGREEMENT_LIST


Check Promotion Agreement Page UI Elements
    [Documentation]             Checking UI Elements for Promotion Agreement Page
    [Tags]                      NEO-10237                   E2E_VISIT-HBP               E2E_VISIT-BP
    Appstate                    Home
    Navigate To Page            PROMOTION_AGREEMENT_LIST

    ${is_run_E2E}=              Check If E2E Execution      ${agreement_MEA_ref}

    IF                          ${is_run_E2E}
        ClickText               ${agreement_MEA_ref}
        ${value_qte_negociee}=                              Get Text Below Agreement    Qté négociée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_qte_negociee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    TG - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_TG_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Flagship Multimarques - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_flagship_multimarque_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Bouteille Géante - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_BG_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Flagship Marque - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_flagship_marque_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Ilot Promo - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_ilot_promo_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Meuble - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_meuble_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Promotainer - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_promotainer_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Présentoir réutilisable - Qté constatée
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_presentoir_reutilisable_qte_constatee_PASTIS_51}
        ${value_qte_negociee}=                              Get Text Below Agreement    Qté gratuité
        Run Keyword And Continue On Failure                 Should Be Equal             ${value_qte_negociee}       ${value_qte_gratuite_PASTIS_51}

        Wait Until Keyword Succeeds                         15 sec                      2 sec                       ScrollTo                    ${OP_trade_attached_BRI}
        Run Keyword And Continue On Failure                 Verify Attribute            (${OP_trade_attached_BRI})[1]                           innerText         ${value_BRI_PASTIS_51}
    ELSE
        ClickElement            (${agreements_of_the_list})[1]                          #selecting the first agreement in the list
    END

    Run Keyword And Continue On Failure                     VerifyPage                  PROMOTION_AGREEMENT


Check Promotion Page UI Elements
    [Documentation]             Checking UI Elements for Promotion Page
    [Tags]                      NEO-10252                   E2E_VISIT-HBP               E2E_VISIT-BP
    Appstate                    Home
    Navigate To Page            PROMOTION_AGREEMENT_LIST

    ${is_run_E2E}=              Check If E2E Execution      ${agreement_MEA_ref}
    IF                          ${is_run_E2E}
        ClickText               ${agreement_MEA_ref}
    ELSE
        ClickElement            (${agreements_of_the_list})[1]                          #selecting the first agreement in the list
    END

    ScrollTo                    ${OP_trade_attached}
    ClickElement                ${OP_trade_attached}
    Run Keyword And Continue On Failure                     VerifyPage                  PROMOTION
    Run Keyword And Continue On Failure                     VerifyPage                  PROMOTION_DETAILS

    ClickElement                ${button_quotas_promotion_menu}
    Run Keyword And Continue On Failure                     VerifyPage                  PROMOTION
    Run Keyword And Continue On Failure                     VerifyPage                  PROMOTION_QUOTAS

    UseTable                    QP-
    ${value_quota}=             GetCellText                 r2/c4
    Set Global Variable         ${value_quota}
    Log To Report And Console                               quota_value                 ${value_quota}
    Run Keyword If              ${is_run_E2E}               Run Keyword And Continue On Failure                     Should Be Equal             ${value_OP_trade_quota},0    ${value_quota}