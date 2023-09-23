# superstore-dw
A dbt repo for a data warehouse built on top of the Tableau Superstore dataset

# Desenhar um Data Warehouse para a Superstore
O script setup.sql contém instruções SQL que irão criar dois schemas: original
e norm. Este último contém várias tabelas que representam a informação do dataset
Superstore que é disponibilizado gratuitamente pelo Tableau [aqui](https://data.world/stanke/sample-superstore-2018). As várias tabelas
neste schema seguem uma normalização típica de uma base de dados operacional,
em que o objetivo é minimizar a duplicação de informação, de forma a garantir consistência
dos dados e a eficiência de queries operacionais.
O objetivo deste exercício é desenhar um Data Warehouse baseado nestes dados
fonte. Considerando o processo de gestão de encomendas, devemos chegar a uma
solução completa, incluindo:  
- As tabelas que irão ser criadas
- As colunas de cada tabela
- A forma como as tabelas se relacionam entre si (que chaves estrangeiras existem)

Seguir os passos delineados por [Kimball](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/four-4-step-design-process/).
Para cada tabela de factos, depois de identificada a granularidade, começar por perguntar
que tipo de tabela de factos será:  
- Transaction fact table
- Accumulating snapshot fact table
- Periodic snapshot fact table
Para cada tabela de dimensões, definir que tipo de SCD deve ser usado para cada
atributo da dimensão.
