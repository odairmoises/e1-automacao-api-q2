*** Settings ***
Library           RequestsLibrary
Resource          ../resources/variables.resource
Resource          ../resources/keywords/validacoes_usuario.robot

*** Test Cases ***
Consultar Extrato do Usuário por USUARIO_ID
    [Documentation]    Esse teste acessa o endpoint /usuariocartao/${USUARIO_ID}/extrato usando Auth-Token
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=${AUTH_TOKEN_REAL}
    Validar Extrato Usuario Completo    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    ${headers}    200
