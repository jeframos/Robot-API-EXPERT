*** Settings ***
Documentation    PUT /partners

# Este comando serve para buscas as informações do arquivo 'base.robot'
# Este arquivo sera o centralizador de todas as classes criadas
Resource    ../resources/base.robot


*** Test Cases ***
Should Enable A Partner
    
    # Massa de testes gerada na classe 'partner.py'
    # Das linhas 14 até a 20 são steps para preparar a massa de validação
    ${partner}    Factory Enable Partner

    # As linhas comentadas abaixo, foram adicionadas na camada 'helpers.robot', e substituídas 
    # pela Keyword 'Create A New Partner'

    #Remove Partner By Name    ${partner}[name]
    #${response}    POST Partner    ${partner}

    #Log    ${response.json()}

    # Sempre que recebemos uma variavel, e queremos adiciona-la em uma nova variavel,
    # é necessário incluir a Keyword 'Set Variable' para efetuar esse processo!
    #${partner_id}    Set Variable    ${response.json()}[partner_id]

    ${partner_id}    Create A New Partner    ${partner}

    ${response}    PUT Enable Partner    ${partner_id}
    Status Should Be    200

Should Disable A Partner
    
    # Massa de testes gerada na classe 'partner.py'
    # Das linhas 37 até a 51 são steps para preparar a massa de validação
    ${partner}            Factory Disable Partner

    ${partner_id}         Create A New Partner    ${partner}
    PUT Enable Partner    ${partner_id}

    ${response}         PUT Disable Partner    ${partner_id}
    Status Should Be    200


Should Return 404 On Enable A Partner
    
    # Massa de testes gerada na classe 'partner.py'
    # Das linhas 33 até a 42 são steps para preparar a massa de validação
    ${partner}    Factory 404 Partner

    # As linhas comentadas abaixo, foram adicionadas na camada 'helpers.robot', e substituídas 
    # pela Keyword 'Create A New Partner'
   
    # Apaga a massa para garantir que não teremos erro na requisição
    #Remove Partner By Name    ${partner}[name]
    # Cadastra a massa para utilização
    #${response}    POST Partner    ${partner}

  
    # Sempre que recebemos uma variavel, e queremos adiciona-la em uma nova variavel,
    # é necessário incluir a Keyword 'Set Variable' para efetuar esse processo!
    #${partner_id}    Set Variable    ${response.json()}[partner_id]

    ${partner_id}    Create A New Partner    ${partner}

    # Apaga novamente o cadastro desse usuário, pois o foco é ter um ID valido com um usuário inexistente
    Remove Partner By Name    ${partner}[name]

    # Em seguida gerar uma requisição 'PUT Enable' de um cadastro que não existe mais!
    ${response}    PUT Enable Partner    ${partner_id}
    Status Should Be    404

Should Return 404 On Disable A Partner
    
    ${partner}        Factory 404 Partner

    ${partner_id}     Create A New Partner    ${partner}

    Remove Partner By Name    ${partner}[name]

    ${response}         PUT Disable Partner    ${partner_id}
    Status Should Be    404

    