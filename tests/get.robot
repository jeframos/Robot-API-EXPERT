*** Settings ***
Documentation    GET /partners

# Este comando serve para buscas as informações do arquivo 'base.robot'
# Este arquivo sera o centralizador de todas as classes criadas
Resource    ../resources/base.robot

# 'Suite Setup' para ser executado uma unica vez, para atender os dois testes
# Objetivo adicionar massas de testes para validação das requisições
Suite Setup    Create Partner List

*** Test Cases ***
Should Return A Partner List

    # Requisição método GET sem filtro, para retornar todos os cadastros
    ${response}         GET Partners
    Status Should Be    200

    # Sempre adicionar na variavel '${response}', o método '.json()', pois os métodos
    # 'GET/POST/PUT/DELETE' sempre devolvem as respostas no formato string.
    # E precisamos adicionar o método '.json()' para a automação converter e conseguimos
    # efetuar as validações.

    # A Keyword 'Get Length' verifica a qtde. de objetos cadastrados no response
    ${size}    Get Length    ${response.json()}

    # Validando se a lista de objetos cadastrados é maior que 0
    Should Be True    ${size} > 0


Should Search Partner By Name
    
    # Requisição método GET com filtro por nome, para retornar apenas 1 cadastro
    ${response}    Search Partners    mary jane
    Status Should Be    200

    # A Keyword 'Get Length' verifica a qtde. de objetos cadastrados no response
    ${size}    Get Length    ${response.json()}

    # Validando se a lista de objetos cadastrados retorna apenas o cadastro 
    # filtrado pelo nome na indicado na linha 39.
    Should Be True    ${size} == 1

    #Validação        Resultado obtido da requisição | Resultado esperado
    Should Be Equal    ${response.json()}[0][name]     Mercearia da Mary Jane


# Helper para gerar insumo de validação nos testes acima
# Ele será adicionado em uma 'Suite Setup' para ser executado uma unica vez, para atender os dois testes
*** Keywords ***
Create Partner List

    # Os códigos das linhas 13 até 20 é aprenas para garatir a massa de testes para deixar os testes independentes
    # Não é necessário validar resp code para essa geração de massa, e também não precisamos remover a massa!
    # Caso o log apresente resp code '409' para essa geração de usuário não tem problemas, pois a utilidade dele é 
    # apenas de inclusão de massa para validar o método 'GET' chamado abaixo na linha 25.
    ${partners}    Factory Partner List
    
    # O '@' indicado na variavel abaixo, serve para indicar para o 'FOR' que ele está recebendo uma lista 'Chave': 'Valor'
    FOR    ${p}    IN    @{partners}
        # Esse LOP serve para cadastrar todos os parceiros adicionados no método 'Factory Partner List' 
        # criado na classe 'partner.py'. Isso vai fazer com que o teste fique independente
        POST Partner    ${p}
    END