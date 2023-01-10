*** Settings ***
Documentation        Camada de serviços

Library          RequestsLibrary

# Qualquer variavel criada dentro da sessão (*** Variables ***) será criada em caixa alta.
# Sugestão de Padrão do Papito
*** Variables ***
${BASE_URL}      http://localhost:3333/partners

# O '&' é utilizado para indicar que essa variavel vai receber um dicionario de dados "Hash com parametros de chave e valor"
# Se essa variavel estivesse com o '$', o robot entenderia que esses parametros seriam uma String gigante
# Por conversão utilizamos o '&' apenas na camada de (*** Variables ***), na camada de (*** Test Cases ***) utilizamos a keyword
# (Create Dictionary)
&{HEADERS}       Content-Type=application/json    auth_user=qa    auth_password=ninja


*** Keywords ***
POST Partner
    [Arguments]    ${payload}

    ${response}    POST    ${BASE_URL}
    ...            json=${payload}
    ...            headers=${HEADERS}
    ...            expected_status=any    # Parametro capturado da documentação do 'RequestsLibrary' para não acusar como erro resp code =! 200

    [Return]      ${response}


GET Partners

    ${response}    GET    ${BASE_URL}
    ...            headers=${HEADERS}
    ...            expected_status=any    # Parametro capturado da documentação do 'RequestsLibrary' para não acusar como erro resp code =! 200

    [Return]      ${response}

Search Partners
    [Arguments]    ${name}

    # Ao receber o parametro do caso de testes, é necessário adiciona-lo em um dicionario de dados
    # antes de passar como parametro na requisição 'GET'
    ${query}        Create Dictionary    name=${name}
    
    ${response}    GET    ${BASE_URL}
    ...            params=${query}        # Inclusão do 'nome' do usuário para fazer filtro na pesquisa
    ...            headers=${HEADERS}
    ...            expected_status=any    # Parametro capturado da documentação do 'RequestsLibrary' para não acusar como erro resp code =! 200

    [Return]      ${response}

PUT Enable Partner
    [Arguments]    ${partner_id}

                    #      http://localhost:3333/partners/61f49611fed7e07340935c5b/enable
    ${response}    PUT    ${BASE_URL}/${partner_id}/enable
    ...            headers=${HEADERS}
    ...            expected_status=any    # Parametro capturado da documentação do 'RequestsLibrary' para não acusar como erro resp code =! 200

    [Return]      ${response}


PUT Disable Partner
    [Arguments]    ${partner_id}

                    #      http://localhost:3333/partners/61f49611fed7e07340935c5b/disable
    ${response}    PUT    ${BASE_URL}/${partner_id}/disable
    ...            headers=${HEADERS}
    ...            expected_status=any    # Parametro capturado da documentação do 'RequestsLibrary' para não acusar como erro resp code =! 200

    [Return]      ${response}


DELETE Partner
    [Arguments]    ${partner_id}

                    #      http://localhost:3333/partners/61f49611fed7e07340935c5b
    ${response}    DELETE    ${BASE_URL}/${partner_id}
    ...            headers=${HEADERS}
    ...            expected_status=any    # Parametro capturado da documentação do 'RequestsLibrary' para não acusar como erro resp code =! 200

    [Return]      ${response}