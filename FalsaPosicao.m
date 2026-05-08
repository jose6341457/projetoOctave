clear all; %limpa os comandos da tela
clc;
disp('Resolução Numérica de Equações Algébricas e Transcedentais: Método da FALSA POSIÇÃO');
disp('Seja f(x) uma função contínua em I0 = [a,b], com f(a)*f(b)<0');

% Variáveis de entrada
a = input('Entre com o valor de a =');
b = input('Entre com o valor de b =');
f = input('Entre com a função f(x) =', 's');
F = str2func(['@(x)', f]); % Converte f para função anônima
imax = input('CP: Entre com o número máximo de iterações =');
tol = input('CP: Entre com o valor do |ER| desejado =');

% Algoritmo da Falsa Posição
Fa = F(a); Fb = F(b);

if Fa*Fb > 0 % Teste do TVI [cite: 25]
  disp('Erro: Não tem raiz no intervalo inicial [a, b]');
else
    disp('  i        a            b           xNS           F(a)        F(xNS)        |ER|'); % Cabeçalho

    xA = a; % Inicializa x Anterior para o primeiro cálculo do erro

    for i = 1:imax % iterações
        Fa = F(a);
        Fb = F(b);

        % --- ALTERAÇÃO PRINCIPAL: FÓRMULA DA FALSA POSIÇÃO ---
        % Substitui xNS = (a+b)/2 pela fórmula da secante no intervalo
        xNS = (a*Fb - b*Fa) / (Fb - Fa);

        % Cálculo do |ER| => Erro Relativo Estimado
        toli = abs((xNS - xA) / xNS);
        FxNS = F(xNS);

        fprintf('%3i  %11.6f  %11.6f  %11.6f  %11.6f  %11.6f  %11.6f \n', i, a, b, xNS, Fa, FxNS, toli);

        % Critérios de Parada [cite: 26]
        if FxNS == 0
            fprintf('Uma solução exata foi encontrada na iteração i = %3i, com valor de xNS = %11.6f \n', i, xNS);
            break
        end

        if toli < tol && i > 1 % CP: Erro atingido (evita parada na 1ª iteração onde xA é arbitrário)
            fprintf('CP: |ER| atingido! O aproximante da raiz foi encontrado na iteração i = %3i, com valor de xNS = %11.6f e |ER| =%11.6f \n', i, xNS, toli);
            break
        end

        if i == imax
            fprintf('CP: Número máximo i = %i de iterações atingido!', imax);
            break
        end

        % Atualização do valor anterior para a próxima iteração
        xA = xNS;

        % Teste do Próximo Intervalo (TVI) para manter a raiz cercada
        if Fa * FxNS < 0
            b = xNS;
        else
            a = xNS;
        end
