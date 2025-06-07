*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           BuiltIn
Resource          ../resources/variables.resource

*** Keywords ***
GET With Expected Status
    [Arguments]    ${endpoint}    ${headers}    ${expected_status}
    ${response}=    GET On Session    api    ${endpoint}    headers=${headers}    expected_status=${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    [Return]    ${response}

*** Test Cases ***
Consultar Extrato do Usuário por USUARIO_ID
    [Documentation]    Esse teste acessa o endpoint /usuariocartao/${USUARIO_ID}/extrato usando Auth-Token
    Create Session     api    ${BASE_URL_REAL}    verify=False

    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=${AUTH_TOKEN_REAL}

    ${response}=    GET With Expected Status    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    ${headers}    200
    Log    ${response.content}

    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    Dictionary Should Contain Key    ${json}    eventos
    ${size}=    Get Length    ${json['eventos']}
    Should Be True    ${size} > 0
