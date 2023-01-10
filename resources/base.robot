*** Settings ***
Documentation        Aqui tudo começa

Library      factories/partner.py
Library      JSONLibrary

Resource    services.robot
Resource    database.robot
Resource    helpers.robot


*** Keywords ***
Get Fixture
    [Arguments]    ${fixture_file}

    ${fixture}    Load Json From File    
    ...           ${EXECDIR}/resources/fixtures/${fixture_file}.json
    ...           encoding=UTF=8

    [Return]      ${fixture}