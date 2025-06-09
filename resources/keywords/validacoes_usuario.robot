*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    JSONLibrary

*** Keywords ***
Validar Status Code
    [Arguments]    ${response}    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}

Validar Estrutura Extrato Usuario
    [Arguments]    ${json}
    Dictionary Should Contain Key    ${json}    eventos
    ${size}=    Get Length    ${json['eventos']}
    Should Be True    ${size} > 0

Validar Extrato Usuario Completo
    [Arguments]    ${endpoint}    ${headers}    ${status_esperado}
    ${response}=    GET On Session    api    ${endpoint}    headers=${headers}    expected_status=any
    Log    >>> Status Esperado: ${status_esperado}
    Log    >>> Status Recebido: ${response.status_code}
    Log    >>> Body: ${response.content}
    Validar Status Code    ${response}    ${status_esperado}

    IF    '${status_esperado}' == '200'
        ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
        Validar Estrutura Extrato Usuario    ${json}
    END

    [Return]    ${response}
