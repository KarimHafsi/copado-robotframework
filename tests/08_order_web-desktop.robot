*** Settings ***
Resource                        ../resources/web.robot
Suite Setup                     Start Suite
Suite Teardown                  End Suite

*** Test Cases ***
Check Order List Page UI Elements
    [Documentation]             Checking UI Elements for Order List Page
    [Tags]                      NEO-                        UI                          E2E_CMD
    Appstate                    Home
    Navigate To Page            ORDER_LIST
    ${is_run_E2E}=              Check If E2E Execution      ${random_string_furniture_order_comment}

    IF                          ${is_run_E2E}
        Run Keyword And Continue On Failure                 VerifyAttribute             //tr[1]/td[@tabindex\="-1"][3]//a                     title    ${furniture_order_retail_store}

        ${value_order_type}=    GetAttribute                //tr[1]/td[@tabindex\="-1"][4]                        innerText
        ${stripped}=            Strip String                ${value_order_type}         characters=\n
        Run Keyword And Continue On Failure                 Should Be Equal             ${stripped}               Commande de meuble

        ${value_order_delivery_date}=                       GetAttribute                //tr[1]/td[@tabindex\="-1"][6]                        innerText
        ${stripped}=            Strip String                ${value_order_delivery_date}                          characters=\n
        Run Keyword And Continue On Failure                 Should Be Equal             ${stripped}               ${value_delivery_date}

        ${value_order_status}=                              GetAttribute                //tr[1]/td[@tabindex\="-1"][8]                        innerText
        ${stripped}=            Strip String                ${value_order_status}       characters=\n
        Run Keyword And Continue On Failure                 Should Be Equal             ${stripped}               Brouillon
    END

    VerifyPage                  ORDER_LIST


Create Furniture Order - Step 3/3
    [Documentation]             Verify Furniture order in Office Application
    [Tags]                      NEO-                        E2E_CMD                     UI
    Appstate                    Home
    Navigate To Page            ORDER_LIST

    ClickElement                (${orders_of_the_list})[1]

    ${is_run_E2E}=              Check If E2E Execution      ${random_string_furniture_order_comment}

    IF                          ${is_run_E2E}
        Run Keyword And Continue On Failure                 VerifyText                  ${delivery_details}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_hour}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_date}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_address}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_contact}
        Run Keyword And Continue On Failure                 VerifyText                  ${value_delivery_phone}
        Run Keyword And Continue On Failure                 VerifyText                  ${random_string_furniture_order_comment}

        ${value_code_territoire}=                           GetAttribute                ${field_code_territoire}                              innerText
        Run Keyword And Continue On Failure                 Should Not Be Empty         ${value_code_territoire}
    END

    VerifyPage                  ORDER