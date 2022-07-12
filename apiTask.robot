*** Settings ***
Documentation                                           Tests for REST API to query data from USA
Library                                                 SeleniumLibrary
Library                                                 RequestsLibrary
Library                                                 JSONLibrary
Library                                                 Collections



*** Variables ***
${base_url}                                             https://datausa.io



*** Test Cases ***
successful scenario of getting data from the API
          Retrieve state population with correct parameters
Unsuccesful scenario with wrong parameters
          Retrieve state population with wrong parameters

       

*** Keywords ***

Retrieve state population with correct parameters

    ${params} =    Create Dictionary    drilldowns=State    measures=Population   year=latest
    Create Session    testing      ${base_url}      verify=true
    ${resp} =    GET On Session    testing   /api/data   params=${params}

    Status Should Be    200    ${resp}



Retrieve state population with wrong parameters

    ${params} =    Create Dictionary     drilldowns=Stata    measures=Populations    year=latest
    Create Session    tester      ${base_url}      verify=true
    ${response} =    GET On Session    tester   /api/data   params=${params}

    Log To Console        ${response.json()}
    ${Actual_code}=    Convert To String     ${response.status_code}
    Should Be Equal    ${Actual_code}    200
















