clear all;
clc;
f = @(x) cos(x) - x *exp(x);

disp('TVI');
fprintf('   x        f(x)\n');

for x = -10:10
    fx = f(x);
    fprintf('%4d   %8.5f\n', x, fx);
end
