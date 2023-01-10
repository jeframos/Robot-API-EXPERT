*** Settings ***
Documentation        Database helpers connection

Library          RobotMongoDBLibrary.Delete
Library          RobotMongoDBLibrary.Find

# Qualquer variavel criada dentro da sessão (*** Variables ***) será criada em caixa alta.
# Sugestão de Padrão do Papito
*** Variables ***
&{MONGODB_URI}   connection=mongodb+srv://bugereats:Q06suBu5aaDx01QW@cluster0.47xwe2t.mongodb.net/PartnerDB?retryWrites=true&w=majority    database=PartnerDB   collection=partner


*** Keywords ***
Remove Partner By Name
    [Arguments]    ${partner_name}

    ${filter}    Create Dictionary
    ...          name=${partner_name}

    #Comando utilizado da lib 'RobotMongoDBLibrary.Delete', capturado diretamente do arquivo Python
    Delete One    ${MONGODB_URI}    ${filter}

Find Partner By Name
    [Arguments]    ${partner_name}

    ${filter}    Create Dictionary
    ...          name=${partner_name}

    #Comando utilizado da lib 'RobotMongoDBLibrary.Find', capturado diretamente do arquivo Python
    ${results}     Find    ${MONGODB_URI}    ${filter}

    [Return]       ${results}[0]    