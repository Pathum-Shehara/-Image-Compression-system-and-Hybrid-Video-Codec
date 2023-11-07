function [prob, symbol] = symbol_prob(input)
%change this later
%input=DC_encoData;

%probability
[g,~,symbol]=grp2idx(input);
Frequency=accumarray(g,1);

%[symbol Frequency];
prob=Frequency./sum(Frequency);

% T = table(symbol,Frequency,probability);
% T(1:length(Frequency),:);;
end
