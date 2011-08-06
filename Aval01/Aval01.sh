#!/bin/bash
# Este script é um exercício para o Curso Administração de SO Linux
# da Universidade de Caxias do Sul.
#
# O Objetivo deste script é controlar um arquivo com IPs que poderia
# ser usado em uma ACL de proxy, por exemplo.

ArquivoControle="/etc/ips.txt";

# TODO - Se arquivo não existe, crie-o.
touch $ArquivoControle;

function Adicionar(){

# TODO - Testar se IP passado depois do parâmetro "-a" é válido.
ping $1;

#        Caso seja inválido, informar ao usuário e sair com codigo de erro 1.
if test $? -eq 2; then echo "IP inválido"; exit 1; fi;
#EXPLIÇÃO
#	saída 0: ip válido que retornou pacotes.
#	saída 1: ip válido que não retornou pacotes.
#	saída 2: ip inválido que não está no padrão.

# TODO - Inserir IP no "ArquivoControle" sem sobrescreve ro arquivo.
echo $1 >> /etc/ips.txt;

# TODO - Exibir uma mensagem de sucesso para o usuário.
echo "IP adicionado com sucesso";

#        Sair com código de erro 0.
exit 0;

}

function Remover(){

# TODO - Procurar IP passado depois do parâmetro "-d" no "ArquivoControle".
grep -x $1 $ArquivoControle;
#	 Caso seja encontrado, remover e exibir uma mensagem de sucesso. Saia com código de erro 0.
if test $? -eq 0; then sed -i '/'$1'/d' $ArquivoControle; exit 0; fi;
#	 Caso não seja encontrado, exibir mensagem de erro e sair com código de erro 2.
if test $? -eq 1; then echo "IP não encontrado"; exit 2; fi;
# TODO - CUIDADO: Caracteres especiais no IP informado podem fazer um estrago no arquivo. ex.: "192.168.0.*"
# TODO - CUIDADO: Na busca pelo IP, não confunda 192.168.0.1 com 192.168.0.10

}

function Listar(){

# TODO - Listar todos os IPs do "ArquivoControle"
if teste $1==""; then cat $ArquivoControle;
#        Sair com código de erro 0.
exit 0; fi;
# TODO - Caso algum IP tenha sido passado como parâmetro, usar como filtro.
cat $ArquivoControle | grep $1;
#        Exibir IPs encontrados com o filtro e sair com código de erro 0.
if teste $? -eq 0; then exit 0;
#        Caso nenhum IP seja encontrado, exibir mensagem de erro e sair com código de erro 3.
else echo "Nenhum IP encontrado"; exit 3; 

}

function Ajuda(){

# TODO - Informar ao usuário a forma de uso desse script (todas as opções possíveis).
echo " Arquivo Padrão de Controle = /etc/ips.txt";
echo "	-a, --add	Adiciona um ip válido para o arquivo padrão de controle.";
echo "	-d, --delete	Remove um ip que esteja no arquivo padrão de controle.";
echo "	-l, --list	Lista todos os ips que estejam no arquivo padrão de controle.";
echo "	-h, --help	Lista todas as funções do comando Aval01.sh.";
exit 0;

}

# Case para receber parâmetros e chamar função correspondente

# TODO - Aceitar "--add" para chamar a função "Adicionar"
# TODO - Aceitar "--delete" para chamar a função "Remover"
# TODO - Aceitar "--list" para chamar a função "Listar"
# TODO - Aceitar "--help" para chamar a função "Ajuda" 
# TODO - Exibir uma mensagem de "uso" quando o parâmetro passado não for reconhecido
# TODO - Os parâmetros podem estar em qualquer posição e, ainda assim, devem funcionar corretamente

case $1 in
	--add)
		Adicionar $2
	;;
	--delete)
		Remover $2
	;;
	--list)
		Listar $2
	;;
	--help)
		Ajuda
	;;	
esac

case $1 in
	-a)
		Adicionar $2
	;;
	-d)
		Remover $2
	;;
	-l)
		Listar $2
	;;
	-h)
		Ajuda
	;;
	*)
		echo "OPÇÃO INVÁLIDA";
		exit 1;
	;;	
esac