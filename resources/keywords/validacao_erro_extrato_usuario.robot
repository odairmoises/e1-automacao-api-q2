*** Settings ***
Library    Collections
Library    RequestsLibrary
Resource    ../variables.resource
*** Keywords ***

Validar Status Code
    [Arguments]    ${response}    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}

Validar Resposta de Erro do Extrato de Usuário
    [Arguments]    ${endpoint}    ${headers}    ${status_esperado}    ${codigo_esperado}=None    ${mensagem_esperada}=None
    ${response}=    GET On Session    api    ${endpoint}    headers=${headers}    expected_status=any
    Log    >>> Status Esperado: ${status_esperado}
    Log    >>> Status Recebido: ${response.status_code}
    Log    >>> Body: ${response.content}
    Validar Status Code    ${response}    ${status_esperado}

    ${status_esperado_str}=    Convert To String    ${status_esperado}
    IF    '${status_esperado_str}' != '200' and '${response.content}' != ''
        ${json_retorno}=    Evaluate    json.loads('''${response.content}''')    modules=json
        Dictionary Should Contain Key    ${json_retorno}    codigo
        Dictionary Should Contain Key    ${json_retorno}    mensagem

        IF    '${codigo_esperado}' != 'None'
            Should Be Equal    ${json_retorno['codigo']}    ${codigo_esperado}
        END

        IF    '${mensagem_esperada}' != 'None'
            Should Be Equal    ${json_retorno['mensagem']}    ${mensagem_esperada}
        END
    ELSE IF    '${response.content}' == ''
        Log    >> Corpo da resposta está vazio, não será feita validação de campos JSON.
    END

    RETURN    ${response}
