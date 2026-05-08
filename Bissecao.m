clear all; clc;
disp('Resolução Numérica de Equações Algébricas e Transcedentais: Método da Bisseção');
disp('Seja f(x) uma função contínua em I0 = [a,b], com f(a)*f(b)<0');

% --- Variáveis de entrada ---
f = input('Entre com a função f(x) (ex: x^3-3): ', 's');
F = str2func(['@(x)', f]);

a = input('Entre com o valor de a = ');
b = input('Entre com o valor de b = ');
imax = input('CP: Entre com o número máximo de iterações = ');
tol = input('CP: Entre com o valor do |ER| desejado = ');

% --- Algoritmo da Bisseção ---
Fa = F(a);
Fb = F(b);

if Fa * Fb > 0
    disp('Erro: O TVI não foi satisfeito (f(a) e f(b) têm o mesmo sinal).');
else
    % Cabeçalho da Tabela
    fprintf('\n%3s | %10s | %10s | %10s | %10s | %10s | %10s\n', 'i', 'a', 'b', 'xNS', 'F(a)', 'F(xNS)', '|ER|');
    disp(repmat('-', 1, 85));

    for i = 1:imax
        xNS = (a + b) / 2;
        FxNS = F(xNS);
        Fa = F(a);

        % Cálculo do Erro Relativo (usando a variação do intervalo)
        % Na bisseção, o erro absoluto é (b-a)/2
        toli = abs((b - a) / (2 * xNS));

        % Impressão dos resultados
        fprintf('%3i | %10.6f | %10.6f | %10.6f | %10.6f | %10.6f | %10.6e\n', i, a, b, xNS, Fa, FxNS, toli);

        % --- Critérios de Parada ---
        if FxNS == 0
            fprintf('\n>> Solução exata encontrada em i = %d: xNS = %.11f\n', i, xNS);
            break;
        end

        if toli < tol
            fprintf('\n>> CP: |ER| atingido em i = %d: xNS = %.11f com |ER| = %.2e\n', i, xNS, toli);
            break;
        end

        if i == imax
            fprintf('\n>> CP: Número máximo de iterações (%i) atingido!\n', imax);
            break;
        end

        % --- Teste do Próximo Intervalo (TVI) ---
        if Fa * FxNS < 0
            b = xNS;
        else
            a = xNS;
        end
    end
end
