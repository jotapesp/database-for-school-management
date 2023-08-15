# Projeto de Banco de Dados de uma escola de ensino médio

(PT-BR)
Esse é o projeto de Banco de Dados para gerenciamento escolar inicialmente configurado para uma escola de ensino médio. O banco de dados tem suporte desde o histórico escolar do aluno, como notas, ao gerenciamento financeiro da instituição, como folha de pagamento, armazenando e gerando dados do salário de professores, funcionários e também, gerenciamento de turnos de trabalho e horários de aula.

### Feito com

[![MySQL](https://img.shields.io/badge/MySQL-000?style=for-the-badge&logo=mysql)](https://dev.mysql.com/doc/refman/8.0/en/)

### Como usar

(PT-BR)
* Executar os scripts MySQL.
* Cada um dos arquivos contidos nesse diretório são uma parte do script e estão descritos abaixo:
  - [`script_criarDB.sql`](https://github.com/jotapesp/database-for-school-management) - execute esse _script_ em um servidor MySQL para criar o Banco de Dados chamado `school` populado com as tabelas que serão descritas mais adiante.
  - [`script_persistenciadedados.sql`](https://github.com/jotapesp/database-for-school-management) - execute esse _script_ para popular o Banco de Dados com dados fictícios afim de testá-lo.
  - [`script_queries.sql`](https://github.com/jotapesp/database-for-school-management) - execute esse _script_ para extrair informações do Banco de Dados com a finalidade de testá-lo. As informações extraídas pelas queries contidas nesse _script_ são descritas mais adiante.

### Descrição do Banco de Dados

* [`diagramaEER`](https://github.com/jotapesp/database-for-school-management) - Esse arquivo contido no repositório contém o modelo lógico completo do banco de dados, a imagem abaixo é um screenshot desse modelo:
[![Modelo Lógico](https://i.imgur.com/ULDIRfe.png)](https://github.com/jotapesp/database-for-school-management)

* Tabelas

  - **Cidade**: tabela exclusivamente criada para armazenar informações de cidades para cadastro de endereços. Criado em uma tabela separada para facilitar depois nas queries e análise de dados.

  - **Estado**: tabela exclusivamente criada para armazenar informações dos estados do Brasil para cadastro de endereços. Criado em uma tabela separada para facilitar depois nas queries e análise de dados.

  - **Ano**: tabela exclusivamente criada para armazenar os anos de funcionamento da escola, por exemplo, 2020, 2021, 2022 e 2023.

  - **Dia da semana**: tabela imutável utilizada para armazenar os dias da semana, afim de facilitar depois na queries de busca horários, por exemplo, o que também facilita a aplicação que vai utilizar esse BD a gerar essas informações para o usuário.

  - **Função**: essa tabela armazeda informações das funções que podem ser empenhadas pelos funcionários da escola, como por exemplo, professor, diretor, zelador. Essa tabela também armazena informação base de salário de cada função, mas cada funcionário terá sua informação de salário individual em outra tabela.

  - **Série**: tabela que armazena informação sobre as séries que os alunos podem ser matriculados na escola, como por exemplo, para uma escola de ensino médio, 1o, 2o e 3o anos.

  - **Matéria**: cada matéria é uma linha dessa tabela, junto com um breve campo de descrição que pode ser utilizado como um syllabus curto, afim de descrever a matéria, como o que é ensinado, por exemplo.

  - **Pessoa**: tabela para armazenar informações das pessoas que tem um tipo de cadastro na escola. Essa é uma tabela geral, ou seja, ainda não há especialização/diferenciação de quem é professor, aluno, pai de aluno. Essa tabela serve para armazenar informações básicas das pessoas, como nome, sobrenome, endereço, CPF, email, telefone, etc.

  - **Aluno**: essa tabela armazena os IDs das pessoas cadastradas na tabela Pessoa que são alunos da instituição. Cada linha contém, o ID da tabela pessoa, um ID próprio da tabela Aluno e um código que é o registro escolar do aluno.

  - **Colaborador**: essa tabela armazena os IDs das pessoas cadastradas na tabela Pessoa que são colaboradores da instituição, que possuem algum vínculo de trabalho, desde professores, até secretárias, diretores, zeladores, entre outros. Cada linha dessa tabela é referente a uma pessoa que seria um colaborador, contendo, o ID para a tabela Pessoa, um ID próprio da tabela Colaborador, um código único que é o registro de colaborador, o ID da função do colaborador, que vai fazer a ligação com a tabela Função, o salário específico desse colaborador (informado em horas) e uma variável Booleana que identifica esse colaborador como professor, ou não (`True` ou `1`, se for professor, `False` ou `0` se não for professor). Esse último atributo foi adicionado para facilitar a identificação do tipo de funcionário, dado que o cálculo do salário semanal e mensal do colaborador muda se ele/ela for professor, ou não.

  - **Responsável**: essa tabela armazena os IDs das pessoas cadastradas na tabela Pessoa que são pais de aluno ou responsáveis por algum aluno da instituição. Cada linha contém, o ID da tabela Pessoa e um ID próprio para a tabela Responsável.

  - **Turma**: a tabela Turma armazena as informações de cada turma de alunos. Enquanto Série é sobre as séries ofertadas, cada linha em Turma é sobre uma turma relacionada a uma série, por exemplo, enquanto as séries são 1, 2 e 3 anos, cada linha de turma é 1 ano A do ano de 2023, 2 ano A do ano de 2023 e 3 ano A do ano de 2023. Os atributos da tabela incluem um ID próprio da tabela Turma, um ID da tabela Ano, que irá identificar que ano essa turma está relacionada, um ID para a tabela Série, indicando a série a qual ela representa, e um atributo de Título, que representa o nome a turma.

  - **Turno**: essa tabela armazena os turnos de trabalho da escola. Cada linha representa 1 turno diferente, sendo os atributos hora de início e hora de fim responsáveis por caracterizar os horários de trabalho desse turno e ID Turno o id próprio da tabela, e o atributo Descrição, onde o usuário pode inserir informações extras para facilitar a identificação do turno e descrevê-lo. Por exemplo, hora de início: 7:00, hora de fim: 12:00 - Descrição: "Turno comercial período matutino".

  - **Horário de aulas**: de maneira análoga a tabela Turno, essa tabela armazena os horários padrões de aula.

  - **Curso**: cada linha dessa tabela representa um curso ofertado pela instituição. Um curso é uma instância única que relaciona matéria lecionada e a série para qual essa matéria é ofertada (indicando nível e tópicos de estudo). Outros atributos da tabela são nome do curso (enquanto a matéria pode ser Matemática, por exemplo, o curso pode ser Álgebra Linear e Geometria Analítica, ou simplesmente, Matemática Básica I), código único do curso, para facilitar a identificação e busca por dados, além de um atributo que informa a quantidade de horas aula por semana (carga horária semanal) que deve ser disponibilizada para esse curso.

  - **Histórico**: cada aluno tem um histórico próprio, que é identificado por um ID de Histórico, o qual será utilizado por outras tabelas para armazenar notas desse aluno para cada curso.

  - **Notas**: a tabela notas contém todas as notas registradas por professores. Cada nota possui alguns atributos de identificação, como um ID próprio para a tabela Notas (ID Notas) e um ID que relaciona essa nota a um historico específico, esse, por sua vez, que é exclusivo de cada aluno. Outros atributos incluem o valor da nota, o peso e o termo (por exemplo, no caso de bimestres, deverá ser informado qual o número do bimestre, para facilitar cálculos de médias pela aplicação, e agrupamento de dados)

  - **Aluno_Responsável**: a tabela Aluno_Responsável serve como uma conexão entre as tabelas Aluno e Responsável, onde cada linha contém o ID de um Aluno e o ID de um Responsável por aquele aluno, podendo, assim, um aluno ser cadastrado com mais de um responsável (pai e mãe) e um responsável ser relacionado a mais de um aluno (ter múltiplos filhos, por exemplo). Essa tabela também contém um atributo que determina o tipo de relacionamento do responsável com o aluno (ENUM("pai", "mãe", "avô/avó", "irmão/irmã", "outro")).

  - **Curso_Turma**: a tabela Curso_Turma realiza a conexão entre as tabelas Curso e Turma, adicionando também informação de qual professor é responsável pelo curso para a dada turma. Cada linha possui os atributos de relacionamento/referência (ID Turma, ID Curso, ID professor, ID ano), além de um ID próprio dessa tabela.

  - **Colaborador_Turno**: a tabela Colaborador_Turno realiza a conexão entre as tabelas Colaborador e Turno, no caso de um colaborador não ser professor (no caso de ser professor, essa conexão é feita pela associação da tabela Curso_Turma com Curso_Turma_Horário). Cada linha possui os atributos de relacionamento/referência (ID Colaborador, ID Turno, ID dia da semana, ID ano), que liga uma instância de Colaborador a uma instância de Turno.

  - **Curso_Turma_Horario**: essa tabela, é, em associação com a tabela Curso_Turma, responsável por definir os turnos de trabalho dos professores e os horários de aula de cada curso, servindo tanto para informações sobre a folha de pagamento de professores como horário de aulas de alunos. Cada linha dessa tabela contém os atributos de referência ID Curso_Turma (que relaciona essa tabela a Curso_Turma), ID Dia da semana e o ID do Horário de aula.

  - **Histórico_Curso_Turma**: a tabela Histórico_Curso_Turma estabelece a relação entre a tabela Histórico, ou seja, uma relação indireta a uma instância de Aluno, com cada instância de Curso que o aluno está matriculado. Dessa forma, indiretamente, essa tabela também conecta as notas aos alunos e aos cursos. Os atributos principais são os de referência, ID do Histórico e ID Curso_Turma.


### Recuperação dos dados através das _Queries_ pré-definidas em _script_

* O _script_ [`script_queries.sql`](https://github.com/jotapesp/database-for-school-management) foi criado com algumas _queries_ que retornam dados armazenados, e essas são:
  - 1. Recupera informações sobre o boletim de um aluno específico através do nome completo dele. O exemplo segue os dados inseridos no _script_ de persistência dos dados.

  - 2. Busca os cursos os quais um aluno específico está matriculado.

  - 3. Criado um cenário de promoção onde os clientes ganham 1 cupom de 10% de desconto a cada R$500 gastos (excluindo frete) na plataforma. Mostra tabela com total gasto e quantos cupons o cliente recebe (considerando que um cliente que gasta, por exemplo, 499.99 será arredondado para cima, ou seja, 500, desse modo, ele estará elegível a receber 1 cupom por essa quantia).

  - 4. Busca e exibe na tela os horário de aula de um aluno específico para o ano de 2023. A busca é efetuada através do nome completo do aluno.

  - 5. Retorna uma tabela com as informações de contato dos responsáveis de todos os alunos. A tabela exibe nome do aluno, nome do responsável e telefone de contato do responsável.

  - 6. Mostra o salário de todos os professores em ordem decrescente (considerando a estimativa mensal). A tabela possui as colunas de nome completo do professor, salário semanal e a estimativa em 1 mês de trabalho (estimativa pois os valores podem variar de mês pra mês, o que deve ser analisado pela aplicação, como por exemplo, quais dias são úteis, etc.)

  - 7. Analogamente ao item 6, mostra o salário de todos os colaboradores que não são professores, em ordem decrescente (considerando a estimativa mensal).

  - 8. Junta as tabelas dos items 6 e 7, mostrando a folha de pagamento da escola, ordenando os dados em ordem decrescente por valor estimado mensal.
