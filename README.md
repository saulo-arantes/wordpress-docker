# wordpress-docker
Automatizando o desenvolvimento com wordpress usando shell e docker

Para iniciar o processo de criação dos containers, rode o comando:

```
./start.sh
```

Existe também a possibilidade de importar um arquivo SQL para o container do banco de dados. Este processo é feito também durante a execução do primeiro comando acima, mas pode ser feito separadamente a qualquer momento, para isso execute:

```
./import.sh
```

Para realizar o dump do banco de dados existente no container, execute: 

```
./export.sh
```
