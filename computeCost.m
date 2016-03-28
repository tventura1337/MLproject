% Computes cost function using training data X & y using parameter theta
function J = computeCost(X, y, theta)

% hypothesis function (h) is innner product of theta and training data X inputted into sigmoid function
% h is a function of X
h = sigmoid(theta * X);

% m is number of training examples
m = length(X);

J = (1/m) * sum(-y' * log(h) - (1 - y') * log(1 - h))

end
