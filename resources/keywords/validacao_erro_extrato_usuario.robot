*** Keywords ***
Validar Resposta de Erro do Extrato de Usuário
    [Arguments]    ${endpoint}    ${headers}    ${status_esperado}
    ${response}=    GET On Session    api    ${endpoint}    headers=${headers}    expected_status=any
    Log    >>> Status Recebido: ${response.status_code}
    Log    >>> Body: ${response.content}
    Should Contain    ${status_esperado}    ${response.status_code}
    IF    '${response.content}' != ''
        ${json_retorno}=    Evaluate    json.loads('''${response.content}''')    modules=json
        Dictionary Should Contain Key    ${json_retorno}    codigo
        Dictionary Should Contain Key    ${json_retorno}    mensagem
    ELSE 
        Log    >> Corpo da reposta está vazio, não será feita validação de campos JSON.
    END
    RETURN    ${response}
