function diffValues = differential(DC_Val)
    % Initialize the difference values array
    diffValues = zeros(size(DC_Val));
    
    % Compute the difference for each value
    for i = 1:numel(DC_Val)
        if i > 1
            % Take the difference with the previous value
            diffValues(i) = DC_Val(i) - DC_Val(i-1);
        else
            % The first value remains unchanged
            diffValues(i) = DC_Val(i);
        end
    end
end
