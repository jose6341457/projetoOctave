clear all;

f = @(x) x.^3 - 5*x + 1;

disp('TVI');
fprintf('   x        f(x)\n');

for x = -10:10
    fx = f(x);
    fprintf('%4d   %8.5f\n', x, fx);
end
