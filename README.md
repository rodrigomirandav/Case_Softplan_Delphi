# 📥 Soft Downloader

Este projeto foi desenvolvido para um desafio de técnico da empresa SoftPlan, localizada na cidade de Florianópolis, para a vaga de "Desenvolvedora Delphi PL - Cód. 3150 (Segmento de Justiça)".
<hr>
🚀 Tecnologias
<hr>
<ul>
  <li>📃Delphi 10.4 Community Edition</li>
  <li>🗄 Banco de dados SQLLite</li>
  <li>📋SQL</li>
</ul>
<hr>
💻 Projeto
<hr>
<p>O projeto consiste em desenvolver um software para efetuar o download de arquivos.</p>
<p>Este sistema deve permitir que os usuários possam efetuar um download de um arquivo através da sua URL, permitir listar todos os arquivos que foram realizados o download e também permitir que a pessoa cancele o download a qualquer momento.</p>
<hr>
🗃 Instalação
<hr>
<p>Todos os arquivos necessário para a execução do sistema estão localizados na pasta "Pasta Exe do Sistema SoftDownloader" deste repositório.</p>
<ul>
  <li>💻 SoftDownloader.exe -> É o arquivo para inicializar o sistema</li>
  <li>🗄 softdownloader.db -> É o arquivo do banco de dados SQLLite </li>
  <li>⚙ ssleay32.dll -> DLL necessária para conexão segura usando SSL/TLS</li>
  <li>⚙ libeay32.dll -> DLL necessária para conexão segura usando SSL/TLS</li>
</ul>
<hr>
🖥Telas do sistema
<hr>
<ul>  
  <li> Tela de splash </li>
</ul>
<img src="https://rodrigomiranda.s3.amazonaws.com/Splash.png">
<ul>  
  <li> Tela principal </li>
</ul>
<img src="https://rodrigomiranda.s3.amazonaws.com/Tela+principal.png">
<ul>  
  <li> Lista de downloads realizados </li>
</ul>
<img src="https://rodrigomiranda.s3.amazonaws.com/Lista+Downloads.png">
<hr>
💩 Desafios técnicos encontrados 
<hr>
<ul>
  <li>Um dos maiores problemas que encontrei foi ao utilizar o componente TIDHTTP juntamente com uma TThread, ocasionando assim a não entrega da totalidade do desafio, ao tentar efetuar o disconect do da requisição do arquivo, o TIDHTTP não conseguia desconectar ocasionando assim erro de memória da Thread</li>
  <li>O outro seria de ter um entendimento para uma perfeita criação da estrutura do MVC, faltou um pouco a visão de mundo da área pois trabalho muito tempo para uma empresa bem pequena. Vou buscar conhecimentos nesta parte pois é um padrão muito bem organizado.</li>
  <li>O case foi bem importante para aguçar mais alguns assuntos que são realmente importantes na área de programação</li>
  <li>A falta de tempo do programador 🧑‍💻 para melhor trabalhar os gaps encontrados</li>
</ul>

