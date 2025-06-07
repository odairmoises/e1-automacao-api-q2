*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           BuiltIn
Resource          ../resources/variables.resource

*** Keywords ***
*** Keywords ***
*** Keywords ***
Validar_Requisicao
    [Arguments]    ${endpoint}    ${headers}    ${status_esperado}
    ${status_esperado}=    Convert To Integer    ${status_esperado}
    ${response}=    GET On Session    api    ${endpoint}    headers=${headers}    expected_status=any
    Log    >>> Status Esperado: ${status_esperado}
    Log    >>> Status Recebido: ${response.status_code}
    Log    >>> Body: ${response.content}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}
    [Return]    ${response}


*** Test Cases ***

Token Inválido Deve Retornar 401
    [Documentation]    Testa a API com token inválido para garantir resposta 401 Unauthorized
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=token_invalido123
    Validar_Requisicao    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    ${headers}    401

Token Ausente Deve Retornar 401
    [Documentation]    Testa a API sem o header Auth-Token e valida 401 Unauthorized
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    Validar_Requisicao    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    ${headers}    401

Usuario Inexistente Deve Retornar 404
    [Documentation]    Testa a API com USUARIO_ID inexistente e valida retorno 404 Not Found / sem extrato?
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=${AUTH_TOKEN_REAL}
    ${usuario_inexistente}=    Set Variable    ${USUARIO_INEXISTENTE}
    Validar_Requisicao    /server-sigom/rest/usuariocartao/${usuario_inexistente}/extrato    ${headers}    404

Usuario Mal Formatado Deve Retornar 400
    [Documentation]    Testa a API com USUARIO_ID mal formatado e valida 400 Bad Request
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=${AUTH_TOKEN_REAL}
    ${usuario_malformatado}=    Set Variable    |    |   _   |
    Validar_Requisicao    /server-sigom/rest/usuariocartao/${usuario_malformatado}/extrato    ${headers}    400

Metodo HTTP Errado Deve Retornar 405
    Create Session    api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=${AUTH_TOKEN_REAL}
    ${response}=    POST On Session    api    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    headers=${headers}    expected_status=405
    Should Be Equal As Integers    ${response.status_code}    405
