*** Settings ***
Documentation    helpers

Resource    base.robot

*** Keywords ***
Create A New Partner
    [Arguments]    ${partner}

    Remove Partner By Name    ${partner}[name]
    ${response}    POST Partner    ${partner}    

    #Log    ${response.json()}

    # Sempre que recebemos uma variavel, e queremos adiciona-la em uma nova variavel,
    # é necessário incluir a Keyword 'Set Variable' para efetuar esse processo!
    ${partner_id}    Set Variable    ${response.json()}[partner_id]    

    [Return]    ${partner_id}
