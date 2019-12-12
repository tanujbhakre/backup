function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices.
%
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);

% You need to return the following variables correctly
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
big_delta_one = zeros(size(Theta1));
big_delta_two = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


for inputCounter = 1:m
  x = X(inputCounter,:);
  biased_x = [1; x'];
  z_two =Theta1 * biased_x;
  a_two = sigmoid(z_two);

  a_two_biased = [1; a_two];
  z_three = Theta2 * a_two_biased;
  a_three = sigmoid(z_three);
  h_of_x = a_three;
  y_value = y(inputCounter);
  recoded_y = zeros(num_labels,1);
  recoded_y(y_value) = 1;

  J = J +( (-recoded_y' * log(h_of_x)) - ( (1.-recoded_y') * log((1.-h_of_x)) ))./m;

  delta_three = a_three - recoded_y;

  delta_two = Theta2' * delta_three .* sigmoidGradient([1; z_two]);

  big_delta_two =  big_delta_two + delta_three * a_two_biased';
  big_delta_one = big_delta_one + delta_two(2:end) * biased_x';


end;
  reg_theta1 = Theta1(:,2:end);
  reg_theta2 = Theta2(:,2:end);
  J = J + ((lambda * ((sum(sum(reg_theta1.^2)))+(sum(sum(reg_theta2.^2)))) )./(2*m));

  theta1_for_reg = [zeros(size(Theta1,1),1) Theta1(:,2:end)];
  theta2_for_reg = [zeros(size(Theta2,1),1) Theta2(:,2:end)];

  Theta1_grad = (big_delta_one./m) + (lambda * theta1_for_reg)./m;
  Theta2_grad = (big_delta_two./m) + (lambda * theta2_for_reg)./m;;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
