*** Variables ***
${BASE_URL_FAKE}        https://IP:PORTA
${BASE_URL_REAL}        https://teste.empresa1.com.br:8444/
${AUTH_TOKEN_FAKE}      fa5kYSBlfsfsSBzdGc1RFM=
${USUARIO_ID}      619727
${USUARIO_INEXISTENTE}    §
${AUTH_TOKEN_REAL}    cmV2ZW5kYSBlbXByZXNhMSBzdGc1RFM=
${JSON_EXTRATO_ESPERADO}    ${CURDIR}/../resources/data/extrato_usuario_teste.json