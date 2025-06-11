*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    JSONLibrary
Library    OperatingSystem

*** Keywords ***

Validar Estrutura Extrato Usuario
    [Arguments]    ${json}
    Dictionary Should Contain Key    ${json}    eventos
    ${size}=    Get Length    ${json['eventos']}
    Should Be True    ${size} > 0
#Estrutura JsonResponse de Eventos de forma Fixa em Keywords
Validar Campos do Evento de Extrato 
    [Arguments]    ${evento}

    Dictionary Should Contain Key    ${evento}    id
    Dictionary Should Contain Key    ${evento}    numeroSerieCartao
    Dictionary Should Contain Key    ${evento}    usuarioId
    Dictionary Should Contain Key    ${evento}    dataHora
    Dictionary Should Contain Key    ${evento}    dataHoraGMT3
    Dictionary Should Contain Key    ${evento}    valor
    Dictionary Should Contain Key    ${evento}    origem
    Dictionary Should Contain Key    ${evento}    tipoCartao
    Dictionary Should Contain Key    ${evento}    saldo
    Dictionary Should Contain Key    ${evento['tipoCartao']}    codigo
    Dictionary Should Contain Key    ${evento['tipoCartao']}    descricao

Carregar JSON de arquivo
    [Arguments]    ${caminho_arquivo}
    ${conteudo}=    Get File    ${caminho_arquivo}
    ${json}=    Evaluate    json.loads('''${conteudo}''')    modules=json
    RETURN    ${json}


Validar Status Code
    [Arguments]    ${response}    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}
Validar Extrato Usuario Completo com responseBody
    [Arguments]    ${endpoint}    ${headers}    ${status_esperado}    ${arquivo_json_esperado}
    ${response}=    GET On Session    api    ${endpoint}    headers=${headers}    expected_status=any
    Log    >>> Status Esperado: ${status_esperado}
    Log    >>> Status Recebido: ${response.status_code}
    Log    >>> Body: ${response.content}
    Validar Status Code    ${response}    ${status_esperado}

    IF    '${status_esperado}' == '200'
        ${json_retorno}=    Evaluate    json.loads('''${response.content}''')    modules=json
        ${json_esperado}=    Carregar JSON De Arquivo    ${arquivo_json_esperado}
        ${qtde}=    Get Length    ${json_retorno['eventos']}
        Validar Campos do Evento de Extrato    ${json_retorno['eventos'][0]}
    END

    RETURN    ${response}

