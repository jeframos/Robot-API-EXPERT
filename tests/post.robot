*** Settings ***
Documentation    POST /partners

# Este comando serve para buscas as informações do arquivo 'base.robot'
# Este arquivo sera o centralizador de todas as classes criadas
Resource    ../resources/base.robot


*** Test Cases ***
Should Create A New Partner
    [Tags]    wip
    
    # Keyword apaga as msgs presentes no rabbitmq para executar os testes limpos
    Purge Messages

    # Criação de massa de testes buscando através do arquivo 'resources/fixtures/patner.json'
    #${partner_data}    Get Fixture    partner

    # Criação de massa de testes buscando através do arquivo 'resources/factories/patner.py'
    ${partner_data}    Factory New Partner
    
    # Criação da massa de Testes buscando  a massa de testes da classe 'resources/factories/partner.py'
    # ${partner_data}                Create Dictionary    
    #...                       name=Pizzas Papito
    #...                       email=contato@papito.com.br
    #...                       whatsapp=11999999999
    #...                       business=Restaurante

    # Remoção da massa de testes antes de executar um novo teste
    Remove Partner By Name    ${partner_data}[name]    #subtituí a massa hardcoded "Pizzas Papito" pela variavel "${partner_data}[name]"

    # Efetua a requisição POST, e guarda a informação na variavel '${response}'
    ${response}               POST Partner    ${partner_data}

    # Valida se o status code da requisição retornou 201
    Status Should Be    201
    
    # Efetua consulta na tabela que guarda os dados de cadastro
    ${result}           Find Partner By Name    ${partner_data}[name]    #subtituí a massa hardcoded "Pizzas Papito" pela variavel "${partner_data}[name]"

    # Esta keyword compara o resultado do request 'POST Partner' ( ${response.json()}[partner_id] )
    # e compara com os dados consultados pela keyword 'Find Partner By Name' ( ${result}[_id] )
    
    # Sempre adicionar na variavel '${response}', o método '.json()', pois os métodos
    # 'GET/POST/PUT/DELETE' sempre devolvem as respostas no formato string.
    # E precisamos adicionar o método '.json()' para a automação converter e conseguimos
    # efetuar as validações.

    #Validação          Resultado obtido da requisição | Resultado esperado
    Should Be Equal    ${response.json()}[partner_id]    ${result}[_id]

    # Resultado dos dados gerados na requisição 'POST Partner'
    # Log To Console    ${response}         #sera apresentado essa informacao no prompt '<Response [201]>'
    # Log To Console    ${response.json()}  #sera apresentado essa informacao no prompt '{'partner_id': '63b9caef2eb266f9f36d5e5c'}'
    # Log To Console    ${response.json()}[partner_id]  #sera apresentado essa informacao no prompt '63b9caef2eb266f9f36d5e5c'

    # Como é consultada uma lista de dados no banco de dados do MongoDB, foi adicionado a posição [0] do indice
    # Log To Console    ${results}[0]       #sera apresentado essa informacao no prompt '{'_id': '63b9caef2eb266f9f36d5e5c', 'name': 'Pizzas Papito5', 'email': 'contato5@papito.com.br', 'whatsapp': '11999999999', 'business': 'Restaurante', 'active': False, 'created_at': datetime.datetime(2023, 1, 7, 12, 44, 30, 111000), 'updated_at': datetime.datetime(2023, 1, 7, 12, 44, 30, 111000)}'
    # Log To Console    ${results}[0][_id]  #sera apresentado essa informacao no prompt '63b9caef2eb266f9f36d5e5c'

    # Consulta o ultimo e-mail recebido no rabbitmq, o processo é efetuado via requisição API
    # na rota capturada dentro do rabbitmq, botão 'Get Message(s)' para consultar os e-mail recebidos
    ${message}    Get Message

    # Esse log é utilizadp para apresentar no prompt se está retornando as informações
    # esperadas do response
    #Log To Console    ${message}[payload]

    # Esse Log é utilizado para apresentar apenas no report se está retornando as 
    # informações esperadas do response
    Log    ${message}[payload]

    # Validação do ultimo email capturado no rabbitmq,
    # com o e-mail capturado na massa de requisição
    # Validação   Resultado obtido do rabbitmq    | Resultado esperado
    Should Contain    ${message}[payload]            ${partner_data}[email]

Should Return Duplicate Company Name
    [Tags]    bugs        # Tag incluída para validar apenas esse CT
                          # Para executar esse CT no Pronmpt 'robot -d ./logs -i bugs tests/post.robot'
    
    # Variavel que guarda a massa de testes "payload" da requisião POST
    ${partner_data}           Factory Dup Name

    # As linhas comentadas abaixo, foram adicionadas na camada 'helpers.robot', e substituídas 
    # pela Keyword 'Create A New Partner'

    # Antes de Executar limpa a massa cadastrada na base para não dar erro
    #Remove Partner By Name    ${partner_data}[name]
    # Requisição POST gerada para tornar esse teste independente
    #POST Partner    ${partner_data}

    # Essa Keyword retorna um ID, porém o intuito dela nesse teste é apenas efetuar o cadastro da massa
    # de testes para, conseguir de fato efetuar a validação a partir da linha 72.
    Create A New Partner    ${partner_data}

    # Segunda requisição com os mesmos dados, para validar o resp code 409
    ${response}               POST Partner    ${partner_data}
    Status Should Be         409

    # Sempre adicionar na variavel '${response}', o método '.json()', pois os métodos
    # 'GET/POST/PUT/DELETE' sempre devolvem as respostas no formato string.
    # E precisamos adicionar o método '.json()' para a automação converter e conseguimos
    # efetuar as validações.

    #Validação               Resultado obtido da requisição | Resultado esperado
    Should Be Equal          ${response.json()}[message]      Duplicate company name
