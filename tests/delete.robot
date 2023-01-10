*** Settings ***
Documentation    DELETE /partners

# Este comando serve para buscas as informações do arquivo 'base.robot'
# Este arquivo sera o centralizador de todas as classes criadas
Resource    ../resources/base.robot

*** Test Cases ***
Should Remove A Partner
    
    ${partner}          Factory Remove Partner
    ${partner_id}       Create A New Partner    ${partner}

    DELETE Partner      ${partner_id}
    Status Should Be    204

Should Return 404 On Remove Partner
    
    ${partner}          Factory 404 Partner
    ${partner_id}       Create A New Partner    ${partner}

    Remove Partner By Name    ${partner}[name]

    DELETE Partner      ${partner_id}
    Status Should Be    404