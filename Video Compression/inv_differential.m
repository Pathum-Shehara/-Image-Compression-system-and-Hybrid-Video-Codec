function DC_Val = inv_differential(diffValues)
    % Initialize the DC values array
    DC_Val = zeros(size(diffValues));
    
    % Compute the inverse differential coding for each value
    for i = 1:numel(diffValues)
        if i > 1
            % Add the difference with the previous value
            DC_Val(i) = DC_Val(i-1) + diffValues(i);
        else
            % The first value remains unchanged
            DC_Val(i) = diffValues(i);
        end
    end
end
