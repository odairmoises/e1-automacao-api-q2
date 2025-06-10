*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           BuiltIn
Library           JSONLibrary
Resource          ../resources/variables.resource
Resource          ../resources/keywords/validacao_erro_extrato_usuario.robot
Resource          ../resources//keywords/validacao_extrato_usuario.robot

*** Test Cases ***
Consulta com Token Inválido
    [Documentation]    Verifica resposta 401 ao usar token inválido.
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=TOKEN_INVALIDO
    Validar Resposta de Erro do Extrato de Usuário    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    ${headers}    401

Consulta com Usuário Inexistente
    [Documentation]    Verifica resposta 404 ao consultar extrato de usuário inexistente.
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Auth-Token=${AUTH_TOKEN_REAL}
    Validar Resposta de Erro do Extrato de Usuário    /server-sigom/rest/usuariocartao/${USUARIO_INEXISTENTE}/extrato    ${headers}    404

Consulta sem Token
    [Documentation]    Verifica resposta 403 ou 401 ao omitir token de autenticação.
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    Validar Resposta de Erro do Extrato de Usuário    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    ${headers}    401

Consulta com Header Malformado
    [Documentation]    Verifica resposta 400 ou 401 ao enviar header inválido.
    Create Session     api    ${BASE_URL_REAL}    verify=False
    ${headers}=    Create Dictionary
    ...    Invalid-Header=Content-Type=application/json
    Validar Resposta de Erro do Extrato de Usuário    /server-sigom/rest/usuariocartao/${USUARIO_ID}/extrato    ${headers}    401
