# Projeto de Automação com Robot Framework - Testes API Consulta de Extrato

## Estrutura do Projeto

- `tests/` — Scripts de teste Robot Framework (.robot)  
- `resources/variables.resource` — Arquivo com variáveis globais, como URLs, tokens e IDs  
- `results/` — Diretório onde são gerados os relatórios dos testes (log.html, report.html, output.xml)  
- `robot-env/` — Ambiente virtual Python com dependências instaladas  
- `requirements.txt` — Lista de pacotes Python necessários para o projeto  

## Pré-requisitos

- Python 3.10 ou superior  
- Criar e ativar ambiente virtual Python  
- Instalar dependências usando:  
```bash
pip install -r requirements.txt
```

## Como rodar os testes

1. Criar o ambiente virtual (se ainda não existir):  
```bash
python -m venv robot-env
```

2. Ativar o ambiente virtual:  

- Windows PowerShell:  
```powershell
.\robot-env\Scripts\Activate.ps1
```  
- Linux/macOS:  
```bash
source robot-env/bin/activate
```

3. Executar os testes (exemplo executando todos os scripts na pasta `tests`):  
```bash
robot -d results tests/
```

4. Abrir os relatórios gerados:  
- `results/log.html` — Log detalhado dos testes  
- `results/report.html` — Resumo dos resultados  

## Observações importantes

- As variáveis como `${AUTH_TOKEN}`, `${BASE_URL_REAL}` e `${USUARIO_ID}` estão definidas no arquivo `resources/variables.resource`.  
- Atualize o token caso ele expire para garantir o funcionamento dos testes.  
- Os testes cobrem cenários positivos e negativos, como token inválido, usuário inexistente, método HTTP errado, entre outros.  
