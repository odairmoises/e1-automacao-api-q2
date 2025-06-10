*** Settings ***
Library           RequestsLibrary
Resource          ../resources/variables.resource
Resource          ../resources/keywords/validacao_extrato_usuario.robot

*** Test Cases ***
Consultar Extrato do Usuário por USUARIO_ID
    [Documentation]    Esse teste acessa o endpoint /usuariocartao/${USUARIO_ID}/extrato usando Auth-Token
    Create Session     api    ${BASE_URL_REAL}    verify=False

    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=${AUTH_TOKEN_REAL}

    Validar Extrato Usuario Completo com responseBody
    ...    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato
    ...    ${headers}
    ...    200
    ...    ${JSON_EXTRATO_ESPERADO}