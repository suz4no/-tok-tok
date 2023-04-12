#!/bin/bash

# Função que imprime o cabeçalho
print_header() {
    echo "███▀▀██▀▀███ ▄▄█▀▀██▄ ▀████▀ ▀███▀       ███▀▀██▀▀███ ▄▄█▀▀██▄ ▀████▀ ▀███▀"
    echo "█▀   ██   ▀███▀    ▀██▄ ██   ▄█▀         █▀   ██   ▀███▀    ▀██▄ ██   ▄█▀"
    echo "     ██    ██▀      ▀██ ██ ▄█▀                ██    ██▀      ▀██ ██ ▄█▀"
    echo "     ██    ██        ██ █████▄       ████     ██    ██        ██ █████▄"
    echo "     ██    ▀██▄    ▄██▀ ██   ▀██▄             ██    ▀██▄    ▄██▀ ██   ▀██▄"
    echo "   ▄████▄    ▀▀████▀▀ ▄████▄   ███▄         ▄████▄    ▀▀████▀▀ ▄████▄   ███▄"
    echo "╔═══════════╗"
    echo "║ by:suz4no ║"
    echo "╚═══════════╝"
}


# Imprime o cabeçalho
print_header

# Exibe as opções do menu
echo "Escolha uma opção:"
echo "[1] Pingar faixas de IP"
echo "[2] Fazer um port scan em todas as portas"
echo "[3] Fazer um port scan em uma porta específica"

# Lê a opção escolhida pelo usuário
read opcao

# Verifica a opção escolhida e executa a função correspondente
case $opcao in
    1)
        echo "╔═══════════════════════════════════════════════╗"
        echo "║            PINGANDO TODOS OS HOSTS            ║"
        echo "╚═══════════════════════════════════════════════╝"
        echo "MODO DE USAR: 192.168.X."
        echo "Digite a faixa de IP que deseja testar:"

        read faixa_ip

        echo "--------------------------------------------"
        echo "____________________________________________"

        # Realiza o ping em cada endereço IP da faixa
        for ip in $(seq 1 254); do
            ping "$faixa_ip$ip" -c 1 | grep "64 bytes" | cut -d " " -f 4
        done
        ;;
    2)
        echo "╔═══════════════════════════════════════════════╗"
        echo "║            Escaneando Todas Portas            ║"
        echo "╚═══════════════════════════════════════════════╝"
        echo "Digite a faixa de IP que deseja testar:"
        read faixa_ip
        echo "Qual pacote você deseja usar? Recomendação: SYN"
        read flag
        echo "--------------------------------------------"
        echo "____________________________________________"
        # Realiza o scan em todas as portas da faixa de IP
        for porta in $(seq 1 65535); do
            sudo hping3 --"$flag" -p "$porta" -c 1 "$faixa_ip" 2>/dev/null | grep 'flags=SA'
        done
        ;;
    3)
        echo "╔═══════════════════════════════════════════════╗"
        echo "║          Escaneando Porta Específica          ║"
        echo "╚═══════════════════════════════════════════════╝"        
                echo "Digite o IP que deseja testar:"
        read ip
        echo "Digite a porta que deseja verificar:"
        read porta
        echo "Qual pacote você deseja usar? Recomendação: SYN"
        read flag

        echo "--------------------------------------------"
        echo "____________________________________________"

        # Realiza o scan na porta especificada do IP
        sudo hping3 --"$flag" -p "$porta" -c 1 "$ip" 2>/dev/null | grep 'flags=SA'
        ;;
    *)
        echo "Opção inválida!"
        ;;
esac

# Imprime uma mensagem de despedida
echo "Obrigado por usar o TOK TOK!"
