/* Exercício 01 
Listar todos os filmes alugados por um cliente específico, 
incluindo a data de locação e a data de devolução.*/

select C1.NOME as Cliente, F1.TITULO as Filme, L1.DATA_LOC as DataLocacao, L2.DATA_DEVOL as DataDevolucao
from cliente C1
join locacao L1 on C1.COD_CLI = L1.COD_CLI
join locacao_filme L2 on L1.COD_LOC = L2.COD_LOC
join filme F1 on L2.COD_FILME = F1.COD_FILME
where C1.NOME = 'Deonizio Martins'

/* Exercício 02 
Obter uma lista de clientes e seus dependentes.*/

select C.NOME as Cliente, D.NOME as Dependente, DEP.PARENTESCO as Parentesco 
from cliente C
join dependente DEP on C.COD_CLI = DEP.COD_CLI
join cliente D on DEP.COD_DEP = D.COD_CLI;

/* Exercício 03
Listar todos os filmes de um determinado gênero.*/

select F.COD_FILME as idFilme , F.TITULO as Filmes , G.NOME as Generos
from filme F
join genero G on F.COD_GEN = G.COD_GEN
where G.NOME = 'Drama';

/* Exercício 04
Exibir todos os clientes que têm uma profissão específica.*/

select C.COD_CLI as codCliente , C.NOME as nomeCliente , P.NOME
from cliente C
join profissao P on C.COD_PROF = P.COD_PROF
where P.NOME = 'Médico';

/* Exercício 05
Encontrar todos os filmes em uma categoria específica com quantidade 
disponível maior que 5.*/

select F.COD_FILME as codigoFilme , F.TITULO as Titulo , F.QUANTIDADE 
	as Estoque, C.NOME as nomeCategoria
from filme F
join categoria C on F.COD_CAT = C.COD_CAT
where C.NOME = 'Clássico' and F.QUANTIDADE > 5;

/* Exercício 06
Listar todos os atores que participaram de filmes com um determinado título.*/

select A.COD_ATOR as id_Ator , A.NOME as nome_Ator , FA.COD_ATOR, FA.COD_FILME,
	F.TITULO as TituloFilmes
from ator A
join filme_ator FA on A.COD_ATOR = FA.COD_ATOR
join filme F on FA.COD_FILME = F.COD_FILME
where F.TITULO = 'A Espera de Um Milagre'

/* Exercício 07
Obter o endereço completo de um cliente específico.*/

select C.COD_CLI as cliente_id , C.NOME, E.LOGRADOURO, E.COMPLEMENTO,
	E.CIDADE, E.UF, E.CEP, E.NUMERO, E.BAIRRO
from cliente C
join cli_endereco CE on C.COD_CLI = CE.COD_CLI
join endereco E on CE.COD_END = E.COD_END
where C.NOME = 'Deonizio Martins';

/* Exercício 08
Listar todos os filmes e seus respectivos gêneros e categorias.*/

select F.COD_FILME as id_filme , F.TITULO as Titulo,
	G.NOME as Genero, C.NOME as Categoria
from filme F
join genero G on F.COD_GEN = G.COD_GEN
join categoria C on F.COD_CAT = C.COD_CAT

/* Exercício 09 
Mostrar todos os clientes que alugaram um filme específico e a data de 
locação.*/
	
select C.COD_CLI as id_cliente, C.NOME, L.DATA_lOC, F.TITULO
from cliente C
join locacao L on C.COD_CLI = L.COD_CLI
join locacao_filme LF on LF.COD_LOC = L.COD_LOC
join filme F on LF.COD_FILME = F.COD_FILME
where F.TITULO = 'O Show de Truman';

/* Exercício 10 
Exibir a lista de clientes com multas superiores a um valor específico.*/

select 
	C.COD_CLI as id_cliente,
	C.NOME,
	L.DATA_LOC,
	L.DESCONTO,
	L.MULTA, 
	L.SUB_TOTAL
from cliente C
join locacao L on C.COD_CLI = L.COD_CLI
where L.MULTA > 8;
-- Solução mais robusta
select 
	C.COD_CLI as id_cliente,
	C.NOME,
	count(L.COD_LOC) as total_locacoes,
	count(L.COD_LOC) * sum(L.MULTA) as Multas,
	count(L.COD_LOC) * sum(L.SUB_TOTAL) as Subtotal
from cliente C
join locacao L on C.COD_CLI = L.COD_CLI
join locacao_filme LF on L.COD_LOC = LF.COD_LOC
group by C.COD_CLI , C.NOME
	-- having é o where para aggregations
	HAVING COUNT(L.COD_LOC) * SUM(L.MULTA) > 20
order by C.NOME;

/* Exercício 11 
 Listar todas as locações feitas em um período específico.*/

select L.COD_LOC as id_locacao , L.DATA_LOC , LF.DATA_DEVOL, LF.VALOR
from locacao L 
join locacao_filme LF on L.COD_LOC = LF.COD_LOC
where L.DATA_LOC between '2024-04-26' and '2024-05-08';


/* Exercício 12
Obter a quantidade total de filmes alugados por cada cliente.*/

select 
	C.COD_CLI as id_cliente,
	C.NOME,
	C.CPF,
	count(L.COD_LOC) as qtd_Alugados
from cliente C
join locacao L on C.COD_CLI = L.COD_CLI
group by C.COD_CLI , C.NOME , C.CPF
order by C.NOME;

/* Exercício 13
 Listar os clientes e os filmes que eles alugaram, ordenados por data de 
locação.*/

SELECT
    CLI.COD_CLI,
    CLI.NOME AS NOME_CLIENTE,
    F.TITULO AS TITULO_FILME,
    LF.DATA_LOC
FROM
    CLIENTE CLI
INNER JOIN
    LOCACAO L ON CLI.COD_CLI = L.COD_CLI
INNER JOIN
    LOCACAO_FILME LF ON L.COD_LOC = LF.COD_LOC
INNER JOIN
    FILME F ON LF.COD_FILME = F.COD_FILME
ORDER BY
    LF.DATA_LOC;

/* Exercício 14 
Mostrar todos os clientes que moram em uma cidade específica e que 
alugaram filmes de uma categoria específica.*/

SELECT
    CLI.COD_CLI,
    CLI.NOME AS NOME_CLIENTE,
    ENDER.CIDADE,
    F.TITULO AS TITULO_FILME,
    CAT.NOME AS CATEGORIA_FILME
FROM
    CLIENTE CLI
INNER JOIN
    CLI_ENDERECO CE ON CLI.COD_CLI = CE.COD_CLI
INNER JOIN
    ENDERECO ENDER ON CE.COD_END = ENDER.COD_END
INNER JOIN
    LOCACAO L ON CLI.COD_CLI = L.COD_CLI
INNER JOIN
    LOCACAO_FILME LF ON L.COD_LOC = LF.COD_LOC
INNER JOIN
    FILMES F ON LF.COD_FILME = F.COD_FILME
INNER JOIN
    CATEGORIA CAT ON F.COD_CAT = CAT.COD_CAT
WHERE
    ENDER.CIDADE = 'São Paulo'
    AND CAT.COD_CAT = 2;

/* Exercício 15 
Encontrar todos os atores que participaram de pelo menos 5 filmes, listando o 
nome do ator e o número de filmes em que atuou. (DESAFIO)*/

SELECT
    A.NOME AS NOME_ATOR,
    COUNT(FA.COD_FILME) AS NUMERO_FILMES
FROM
    ATOR A
INNER JOIN
    FILME_ATOR FA ON A.COD_ATOR = FA.COD_ATOR
GROUP BY
    A.NOME
HAVING
    COUNT(FA.COD_FILME) >= 5
ORDER BY
    NUMERO_FILMES DESC;

/* Exercício 16 
16 - Exibir a quantidade total de filmes alugados por categoria e gênero, incluindo 
apenas as categorias e gêneros que têm mais de 50 filmes alugados no total 
(DESAFIO)*/

SELECT
    C.NOME AS CATEGORIA,
    G.NOME AS GENERO,
    COUNT(LF.COD_FILME) AS QUANTIDADE_TOTAL
FROM
    LOCACAO_FILME LF
INNER JOIN
    FILMES F ON LF.COD_FILME = F.COD_FILME
INNER JOIN
    CATEGORIA C ON F.COD_CAT = C.COD_CAT
INNER JOIN
    GENERO G ON F.COD_GEN = G.COD_GEN
GROUP BY
    C.NOME, G.NOME
HAVING
    COUNT(LF.COD_FILME) > 5
ORDER BY
    QUANTIDADE_TOTAL DESC;

