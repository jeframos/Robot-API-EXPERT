*** Settings ***
Documentation    RabbitMQ helpers    API

Library    RequestsLibrary

*** Variables ***
${RABBIT_URL}    https://jackal.rmq.cloudamqp.com/api/queues/mdssbfdf/email
&{RABBIT_HEADERS}       Content-Type=application/json    Authorization=Basic bWRzc2JmZGY6ZFU1SVQ2c2lWX3lTUTFzWFR1UWxiTlU5emYyYmkyTWE=

*** Keywords ***
Purge Messages
    
    ${payload}    Create Dictionary
    ...           vhost=mdssbfdf
    ...           name=email
    ...           mode=purge

    ${response}    DELETE    
    ...            ${RABBIT_URL}/contents    
    ...            json=${payload}    
    ...            headers=${RABBIT_HEADERS}

    [Return]    ${response}


Get Message

    ${payload}    Create Dictionary
    ...           vhost=mdssbfdf
    ...           name=email
    ...           truncate=50000
    ...           ackmode=ack_requeue_true
    ...           encoding=auto
    ...           count=1

    ${response}    POST    
    ...            ${RABBIT_URL}/get
    ...            json=${payload}
    ...            headers=${RABBIT_HEADERS}

    # Sempre adicionar na variavel '${response}', o método '.json()', pois os métodos
    # 'GET/POST/PUT/DELETE' sempre devolvem as respostas no formato string.
    # E precisamos adicionar o método '.json()' para a automação converter e conseguimos
    # efetuar as validações.

    # Mesmo a resposta devolvendo apenas 1 objeto "O ultimo objeto gerado", é necessário
    # informar a posição do array, pois devido a resposta ser um json, ele foi configurado 
    # para devolver 'N' objetos, então é necessário indicar a possição que sempre será 
    # zero a primeira posição do array.
    [Return]    ${response.json()}[0]

