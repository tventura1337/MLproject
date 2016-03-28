% sigmoid function used for logistic regression
function a = sigmoid(z)

a = zeros(size(z));

% returns the sigmoid of every value of z
a = 1./(1 + exp.^(-z));

end
